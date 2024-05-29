class Public::HelpController < Public::ApplicationController
  def index
    @email = "themenuuu@gmail.com"
    fresh_when @email
    expires_in 24.hours
  end
end
