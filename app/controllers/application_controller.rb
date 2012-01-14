# -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base
  protect_from_forgery

  # SSLアクセスのみを許可する場合は以下をコメントアウトする
  # force_ssl

  before_filter :login_required
  before_filter :set_locale

  helper_method :current_user

  include CarrotSns::I18nHelper
  include CarrotSns::I18nLocale

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    unless current_user
      flash[:error] = i18n_t("notice", "login_required")
      redirect_to root_path
    end
  end
end
