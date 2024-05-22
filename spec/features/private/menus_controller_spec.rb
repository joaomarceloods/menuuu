require 'rails_helper'

RSpec.feature "Private::MenusControllers", type: :feature do
  subject { page }
  let(:user) { User.create!(email: "user@example.com", password: "password") }
  let(:business) { Business.create!(name: "My Business", user: user) }
  let(:menu) { Menu.create!(name: "My Menu", business: business) }

  describe "#index" do
    context "unauthenticated" do
      describe "content" do
        before { visit "/private/menus" }
        it { is_expected.to have_text("You need to sign in or sign up before continuing.") }
      end
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
          before { click_button "New menu", match: :first }
          it { is_expected.to have_field("Menu name", with: "New Menu (edit)") }
          it { is_expected.to have_button("New section") }
        end

        describe "print qr code" do
          before do
            within ".navigation__bar" do
              click_button "menu"
            end
            within ".navigation__menu" do
              click_link "Print QR Code"
            end
          end
          it { is_expected.to have_selector("body > svg[height=363][width=363]") }
        end
      end
    end
  end

  describe "#show" do
    context "unauthenticated" do
      describe "content" do
        before { visit "/private/menus/1" }
        it { is_expected.to have_text("You need to sign in or sign up before continuing.") }
      end
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        describe "content" do
          before { visit "/private/menus/1" }
          it { is_expected.to have_text("What's your business' name?") }
        end
      end

      context "with business" do
        before { business }

        context "without menu" do
          describe "content" do
            before { visit "/private/menus/1" }
            it { is_expected.to have_http_status(:not_found) }
          end
        end

        context "with menu" do
          let(:path) { "/private/menus/#{menu.id}" }

          context "without section" do
            describe "content" do
              before { visit path }
              it { is_expected.to have_field("Menu name", with: "My Menu") }
              it { is_expected.to have_no_field("Enter section name…") }
              it { is_expected.to have_no_button("New item…") }
            end

            describe "renaming menu", js: true do
              before { visit path }
              before { fill_in "Menu name", with: "New Menu Name" }
              before { refresh }
              it { is_expected.to have_field("Menu name", with: "New Menu Name") }
            end

            describe "adding section" do
              before { visit path }
              before { click_button "New section" }
              it { is_expected.to have_field("Enter section name…", count: 1) }
              it { is_expected.to have_button("New item", count: 1) }
            end
          end

          context "with section" do
            let!(:section) { MenuSection.create!(name: "My Section", menu: menu) }

            describe "updating section", js: true do
              before { visit path }
              before { fill_in "Enter section name…", with: "New section name" }
              before { sleep 0.5 }
              before { refresh }
              it { is_expected.to have_field("Enter section name…", with: "New section name") }
            end

            describe "adding another section" do
              before { visit path }
              before { click_button "New section", match: :first }
              it { is_expected.to have_field("Enter section name…", count: 2) }
            end

            context "without item" do
              before { visit path }

              describe "content" do
                it { is_expected.to have_no_field("menu_item_name") }
              end

              describe "adding item" do
                before { click_button "New item" }
                it { is_expected.to have_field("menu_item_name", count: 1) }
              end
            end

            context "with one item" do
              let!(:item) { MenuItem.create!(name: "My Item", price: 10.00, menu_section: section) }
              before { visit path }

              describe "updating item", js: true do
                before do
                  fill_in "menu_item_name", with: "My Item"
                  fill_in "menu_item_price", with: "10.00"
                  sleep 0.5
                  refresh
                end

                it { is_expected.to have_field("menu_item_name", with: "My Item") }
                it { is_expected.to have_field("menu_item_price", with: "10.00") }
              end

              describe "deleting item", js: true do
                before do
                  find_field("menu_item_name").click
                  within "#menu_item_#{item.id} .toolbar" do
                    accept_confirm "Remove the My Item item permanently?" do
                      click_button "close"
                    end
                  end
                end

                it { is_expected.to have_no_field("menu_item_name") }
              end
            end

            context "with two items" do
              let!(:item_1) { MenuItem.create!(name: "Item 1", price: 10.00, menu_section: section) }
              let!(:item_2) { MenuItem.create!(name: "Item 2", price: 20.00, menu_section: section) }
              before { visit path }

              describe "item order" do
                let(:dom_id_1) { "#menu_item_#{item_1.id}" }
                let(:dom_id_2) { "#menu_item_#{item_2.id}" }
                it { is_expected.to have_selector("#{dom_id_1} + #{dom_id_2}") }

                describe "dragging item 1 after item 2", js: true do
                  let(:row_1_input) { find("#{dom_id_1} #menu_item_name") }
                  let(:row_1_handle) { find("#{dom_id_1} .toolbar__item--handle") }
                  let(:row_2) { find(dom_id_2) }

                  before do
                    row_1_input.click
                    row_1_handle.drag_to(row_2)
                    refresh
                  end

                  it { is_expected.to have_selector("#{dom_id_2} + #{dom_id_1}") }
                end
              end
            end

            context "with ten items" do
              before do
                MenuItem.create!(
                  10.times.map { { name: "Item", menu_section: section } }
                )
              end

              context "with subscription" do
                let!(:subscription) { Subscription.create!(business:, stripe_subscription_id: "sub_123", expired_at: 1.year.from_now) }
                before { visit path }

                describe "content" do
                  it { is_expected.not_to have_content("Free tier: 1 menu and 10 items. Unlock 10 menus and 1,000 items.") }
                  it { is_expected.not_to have_link("Subscribe", href: "/private/stripe_checkout_session") }
                end

                describe "navigation" do
                  before { click_button "menu" }
                  it { is_expected.to have_link("Billing", href: "/private/stripe_portal_session") }
                end
              end

              context "without subscription" do
                before { visit path }

                describe "content" do
                  it { is_expected.to have_content("Free tier: 1 menu and 10 items. Unlock 10 menus and 1,000 items.") }
                  it { is_expected.to have_link("Subscribe", href: "/private/stripe_checkout_session") }
                end

                describe "navigation" do
                  before { click_button "menu" }
                  it { is_expected.not_to have_link("Billing", href: "/private/stripe_portal_session") }
                end
              end
            end
          end
        end
      end
    end
  end
end
