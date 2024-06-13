require 'rails_helper'

RSpec.describe "Private::MenusControllers", type: :request do
  subject { response }
  let(:user) { User.create!(email: "user@example.com", password: "password123@") }
  let(:business) { Business.create!(name: "My Business", user: user) }
  let(:menu) { Menu.create!(name: "My Menu", business: business) }

  describe "#index" do
    context "unauthenticated" do
      before { get "/private/menus" }
      it { is_expected.to redirect_to("/users/sign_in") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        before { get "/private/menus" }
        it { is_expected.to redirect_to("/private/business/new") }
      end

      context "with business" do
        before { business }
        before { get "/private/menus" }
        it { is_expected.to have_http_status(:success) }
      end
    end
  end

  describe "#show" do
    context "unauthenticated" do
      before { get "/private/menus/1" }
      it { is_expected.to redirect_to("/users/sign_in") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        before { get "/private/menus/1" }
        it { is_expected.to redirect_to("/private/business/new") }
      end

      context "with business" do
        before { business }

        context "without menu" do
          before { get "/private/menus/1" }
          it { is_expected.to have_http_status(:not_found) }
        end

        context "with menu" do
          before { menu }
          before { get "/private/menus/#{menu.id}" }
          it { is_expected.to have_http_status(:success) }
        end

        context "with another user's menu" do
          let!(:another_user) { User.create!(email: "another@example.com", password: "password123@") }
          let!(:another_business) { Business.create!(name: "Another Business", user: another_user) }
          let!(:another_menu) { Menu.create!(name: "Another Menu", business: another_business) }
          before { get "/private/menus/#{another_menu.id}" }
          it { is_expected.to have_http_status(:not_found) }
        end
      end
    end
  end

  describe "#create" do
    context "unauthenticated" do
      before { post "/private/menus" }
      it { is_expected.to redirect_to("/users/sign_in") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        before { post "/private/menus" }
        it { is_expected.to redirect_to("/private/business/new") }
      end

      context "with business" do
        before { business }

        context "without params" do
          before { post "/private/menus" }
          it { is_expected.to redirect_to("/private/menus/#{Menu.last.id}") }
        end

        context "with params" do
          before { post "/private/menus", params: { menu: { name: "My Menu" } } }
          it { is_expected.to redirect_to("/private/menus/#{Menu.last.id}") }
        end
      end
    end
  end

  describe "#update" do
    context "unauthenticated" do
      before { patch "/private/menus/1" }
      it { is_expected.to redirect_to("/users/sign_in") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        before { patch "/private/menus/1" }
        it { is_expected.to redirect_to("/private/business/new") }
      end

      context "with business" do
        before { business }

        context "without menu" do
          before { patch "/private/menus/1" }
          it { is_expected.to have_http_status(:not_found) }
        end

        context "with menu" do
          before { menu }

          context "without params" do
            before { patch "/private/menus/#{menu.id}" }
            it { is_expected.to have_http_status(:bad_request) }
          end

          context "with params" do
            before { patch "/private/menus/#{menu.id}", params: { menu: { name: "New Name" } } }
            it { is_expected.to redirect_to("/private/menus/#{menu.id}") }
          end
        end
      end
    end
  end
end
