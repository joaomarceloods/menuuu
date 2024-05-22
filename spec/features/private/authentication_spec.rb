require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  subject { page }
  let(:user) { User.create!(email: "user@example.com", password: "password") }

  describe "root" do
    context "unauthenticated" do
      let!(:menu) { Menu.create(name: "The Menuuu") }
      before { visit "/" }
      it { is_expected.to have_text("Free QR code menu maker") }
    end

    context "authenticated" do
      before { sign_in user }
      before { visit "/" }
      it { is_expected.to have_text("What's your business' name?") }
    end
  end

  describe "sign up" do
    context "authenticated" do
      before { sign_in user }
      before { visit "/users/sign_up" }
      it { is_expected.to have_text("You are already signed in.") }
    end

    context "unauthenticated" do
      before do
        visit "/users/sign_up"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"
      end

      it { is_expected.to have_text("You have signed up successfully.") }
    end
  end

  describe "sign in" do
    context "authenticated" do
      before { sign_in user }
      before { visit "/users/sign_in" }
      it { is_expected.to have_text("You are already signed in.") }
    end

    context "unauthenticated" do
      before do
        user
        visit "/users/sign_in"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "password"
        click_button "Log in"
      end

      it { is_expected.to have_text("Signed in successfully.") }
      it { is_expected.to have_text("What's your business' name?") }

      describe "onboarding" do
        before do
          fill_in "business_name", with: "My Business"
          click_button "Next"
        end

        it "has fields" do
          expect(subject).to have_field("Menu name", with: "New Menu (edit)")
          expect(subject).to have_field("Enter section name…", with: "This is a section")
          expect(page.all('input#menu_item_name').map(&:value)).to eq([
            "Rename this item",
            "Rename the section",
            "Rename the menu at the top",
            "Drag items & sections around",
            "You can delete sections",
            "Set price on the right",
          ])
        end
      end
    end
  end
end
