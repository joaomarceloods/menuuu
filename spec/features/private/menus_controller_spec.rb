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
              it { is_expected.to have_no_field("Section name") }
              it { is_expected.to have_no_button("Add item…") }
            end

            describe "renaming menu", js: true do
              before { visit path }
              before { fill_in "Menu name", with: "New Menu Name" }
              before { refresh }
              it { is_expected.to have_field("Menu name", with: "New Menu Name") }
            end

            describe "adding section" do
              before { visit path }
              before { click_button "Add section…" }
              it { is_expected.to have_field("Section name", count: 1) }
              it { is_expected.to have_button("Add item", count: 1) }
            end
          end

          context "with section" do
            let!(:section) { MenuSection.create!(name: "My Section", menu: menu) }

            describe "updating section", js: true do
              before { visit path }
              before { fill_in "Section name", with: "New section name" }
              before { sleep 0.5 }
              before { refresh }
              it { is_expected.to have_field("Section name", with: "New section name") }
            end

            describe "adding another section" do
              before { visit path }
              before { click_button "Add section…", match: :first }
              it { is_expected.to have_field("Section name", count: 2) }
            end

            context "without item" do
              before { visit path }

              describe "content" do
                it { is_expected.to have_no_field("menu_item_name") }
              end

              describe "adding item", js: true do
                before { click_button "Add item" }
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
                  within ".menu-item .action-bar" do
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

                describe "dragging item 1 before item 2", js: true do
                  let(:row_1) { find(dom_id_1) }
                  let(:row_2) { find(dom_id_2) }
                  before { row_1.drag_to(row_2) }
                  before { refresh }
                  it { is_expected.to have_selector("#{dom_id_2} + #{dom_id_1}") }
                end
              end
            end
          end
        end
      end
    end
  end
end