class ApplicationController < ActionController::Base
  before_action :set_locale, :authorized

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def authorized
    redirect_to root_path unless user_signed_in?
  end
end
