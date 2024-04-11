require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  subject { page }
  let(:user) { User.create!(email: "user@example.com", password: "password") }

  describe "root" do
    context "unauthenticated" do
      before { visit "/" }
      it { is_expected.to have_text("Log in") }
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

        it { is_expected.to have_field("Menu name", with: "Menu") }
        it { is_expected.to have_field("Section name", with: "Eats") }
        it { is_expected.to have_field("Item name", with: "Cheese Burger") }
        it { is_expected.to have_field("Item name", with: "French Fries") }
        it { is_expected.to have_field("Section name", with: "Drinks") }
        it { is_expected.to have_field("Item name", with: "Soda") }
      end
    end
  end
end