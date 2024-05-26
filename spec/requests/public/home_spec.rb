require 'rails_helper'

RSpec.describe "Public::Homes", type: :request do
  let!(:user) { User.create!(email: "user@example.com", password: "password") }
  let!(:business) { Business.create!(name: "My Business", user: user) }
  let!(:menu) { Menu.create!(name: "The Menuuu", business: business, demo: true) }

  subject { response }
  before { get "/" }
  it { is_expected.to have_http_status(:success) }
end
