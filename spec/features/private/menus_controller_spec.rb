require 'rails_helper'

RSpec.feature "Private::MenusControllers", type: :feature do
  subject { page }
  let(:user) { User.create!(email: "user@example.com", password: "password") }
  let(:business) { Business.create!(name: "My Business", user: user) }
  let(:menu) { Menu.create!(name: "My Menu", business: business) }

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

  describe "#show" do
    context "unauthenticated" do
      before { visit "/private/menus/1" }
      it { is_expected.to have_text("You need to sign in or sign up before continuing.") }
    end

    context "authenticated" do
      before { sign_in user }

      context "without business" do
        before { visit "/private/menus/1" }
        it { is_expected.to have_text("What's your business' name?") }
      end

      context "with business" do
        before { business }

        context "with menu" do
          before { menu }
          before { visit "/private/menus/#{business.menus.first.id}" }

          describe "content" do
            it { is_expected.to have_field("Menu name", with: "My Menu") }
            it { is_expected.to have_no_field("Section name") }
            it { is_expected.to have_no_button("Add item…") }
          end

          describe "renaming menu", js: true do
            before { fill_in "Menu name", with: "New Menu Name" }
            before { refresh }
            it { is_expected.to have_field("Menu name", with: "New Menu Name") }
          end

          describe "adding section" do
            before { click_button "Add section…" }
            it { is_expected.to have_field("Section name", count: 1) }
            it { is_expected.to have_button("Add item", count: 1) }

            describe "adding another section" do
              before { click_button "Add section…", match: :first }
              it { is_expected.to have_field("Section name", count: 2) }
              it { is_expected.to have_button("Add item", count: 2) }
            end

            describe "updating section", js: true do
              before do
                fill_in "Section name", with: "My Section"
                sleep 0.5
                refresh
              end
              it { is_expected.to have_field("Section name", with: "My Section") }
            end

            describe "adding item" do
              before { click_button "Add item" }
              it { is_expected.to have_field("menu_item_name", count: 1) }
              it { is_expected.to have_field("menu_item_price", count: 1) }

              describe "adding another item" do
                before { click_button "Add item" }
                it { is_expected.to have_field("menu_item_name", count: 2) }
                it { is_expected.to have_field("menu_item_price", count: 2) }
              end

              describe "updating item", js: true do
                before do
                  fill_in "menu_item_name", with: "My Item"
                  fill_in "menu_item_price", with: "10.00"
                  sleep 0.5
                  refresh
                end

                it "updates the item name and price" do
                  expect(page).to have_field("menu_item_name", with: "My Item")
                  expect(page).to have_field("menu_item_price", with: "10.00")
                end
              end

              describe "deleting item", js: true do
                before do
                  find_field("menu_item_name").click
                  within ".menu-item .action-bar" do
                    accept_confirm "Remove the empty item permanently?" do
                      click_button "close"
                    end
                  end
                end
                it { is_expected.to have_no_field("menu_item_name") }
                it { is_expected.to have_no_field("menu_item_price") }
              end
            end
          end
        end
      end
    end
  end
end
