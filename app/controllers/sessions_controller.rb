# -*- coding: utf-8 -*-

class SessionsController < ApplicationController
  skip_before_filter :login_required, only: [:create]

  def create
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: i18n_t("notice", "logged_in")
    else
      flash[:error] = i18n_t("error", "invalid_a_or_b",
                             item_a: ar_t("user", "login"),
                             item_b: ar_t("user", "password"))
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: i18n_t("notice", "logged_out")
  end
end
