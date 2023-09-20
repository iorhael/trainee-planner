# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  add_flash_types(*FlashHelper::BOOTSTRAP_ALERT_CLASS.keys)

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
