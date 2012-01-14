# -*- coding: utf-8 -*-

class TopController < ApplicationController
  skip_before_filter :login_required, only: [:index, :change_locale]

  def index
  end

  def change_locale
    set_locale(params[:locale])
    redirect_to root_path,
                notice: i18n_t("notice", "successfully_changed",
                               name: i18n_t("label", "language"))
  end
end
