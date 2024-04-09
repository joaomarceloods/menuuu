require 'rails_helper'

RSpec.describe "Private::BusinessesControllers", type: :request do
  subject { response }
  let(:user) { User.create!(email: "user@example.com", password: "password") }
  let(:business) { Business.create!(name: "My Business", user: user) }
  let(:menu) { Menu.create!(name: "My Menu", business: business) }

  describe "#new" do
    context "unauthenticated" do
      before { get "/private/business/new" }
      it { is_expected.to redirect_to("/users/sign_in") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        before { get "/private/business/new" }
        it { is_expected.to have_http_status(:success) }
      end

      context "with business" do
        before { business }
        before { get "/private/business/new" }
        it { is_expected.to redirect_to("/private/menus") }
      end
    end
  end

  describe "#create" do
    context "unauthenticated" do
      before { post "/private/business" }
      it { is_expected.to redirect_to("/users/sign_in") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without params" do
        before { post "/private/business", params: { business: { name: '' } } }
        it { is_expected.to have_http_status(:success) }
        # TODO: assert renders template :new
      end

      context "with params" do
        before { post "/private/business", params: { business: { name: "My Business" } } }
        it { is_expected.to redirect_to("/private/menus/#{Business.last.menus.last.id}") }
      end
    end
  end

  describe "#update" do
    context "unauthenticated" do
      before { patch "/private/business" }
      it { is_expected.to redirect_to("/users/sign_in") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        before { patch "/private/business" }
        it { is_expected.to redirect_to("/private/business/new") }
      end

      context "with business" do
        before { business }

        # TODO: validate presence of name
        context "with empty name" do
          before { patch "/private/business", params: { business: { name: '' } } }
          it { is_expected.to redirect_to("/private/menus") }
        end

        context "with new name" do
          before { patch "/private/business", params: { business: { name: 'New Name' } } }
          it { is_expected.to have_http_status(:success) }
        end
      end
    end
  end
end
