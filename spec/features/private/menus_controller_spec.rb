require 'rails_helper'

RSpec.feature "Private::MenusControllers", type: :feature do
  subject { page }
  let(:user) { User.create!(email: "user@example.com", password: "password") }
  let(:business) { Business.create!(name: "My Business", user: user) }

  describe "#index" do
    context "unauthenticated" do
      before { visit "/private/menus" }
      it { is_expected.to have_text("You need to sign in or sign up before continuing.") }
    end

    context "authenticated" do
      before { sign_in user }

      context "with business" do
        before { business }
        before { visit "/private/menus" }

        describe "content" do
          it { is_expected.to have_field("Business Name", with: "My Business") }
        end

        describe "rename business", js: true do
          before { fill_in "Business Name", with: "My Restaurant" }
          before { refresh }
          it { is_expected.to have_field("Business Name", with: "My Restaurant") }
        end

        describe "add menu" do
          before { click_button "New menu…" }
          it { is_expected.to have_text("Menu was successfully created.") }
          it { is_expected.to have_field("Menu name", with: "Menu") }
          it { is_expected.to have_button("Add section…") }
        end

        describe "print qr code" do
          before do
            within ".navigation-bar" do
              click_button "menu"
            end
            within ".navigation-menu" do
              click_link "Print QR Code"
            end
          end
          pending { is_expected.to have_selector("svg[height=363]") }
        end
      end
    end
  end
end
