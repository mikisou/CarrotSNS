# -*- coding: utf-8 -*-

class TopController < ApplicationController
  skip_before_filter :login_required, only: [:index, :change_locale]

  def index
  end

  def change_locale
    error_msg = i18n_t("error", "failed",
                       action: i18n_t("label", "change_language"))
    if current_user
      unless current_user.profile.update_locale(params[:locale])
        flash[:error] = error_msg
        redirect_to root_path
        return
      end
    end

    if set_locale(params[:locale])
      flash[:notice] = i18n_t("notice", "successfully_changed",
                              name: i18n_t("label", "language"))
    else
      flash[:error] = error_msg
    end
    redirect_to root_path
  end
end
