# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_recaptcha, only: [:create]

  protected

  def check_recaptcha
    v3_secret_key = Rails.application.credentials.dig(:recaptcha, :v3, :secret_key)
    v2_secret_key = Rails.application.credentials.dig(:recaptcha, :v2, :secret_key)
    return if verify_recaptcha(secret_key: v3_secret_key, action: :sign_in, minimum_score: 0.5)
    return if verify_recaptcha(secret_key: v2_secret_key)

    @show_recaptcha_checkbox = true
    flash[:alert] = I18n.t('recaptcha.errors.verification_failed')
    build_resource(sign_up_params)
    render :new
  end
end
