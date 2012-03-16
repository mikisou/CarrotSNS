# -*- coding: utf-8 -*-

# SNSポータルトップ用コントローラ
class TopController < ApplicationController
  skip_before_filter :login_required, only: [:index, :change_locale]

  # SNS全体のトップ画面
  def index
  end

  # 言語切り替え実行
  #
  # ログイン状態の場合は、当該ユーザーのプロフィール情報のロケール値を変更する。
  #
  # 非ログイン状態の場合は、I18nHelper::set_localeにより、ロケール情報を一時的に変更する。
  # @param locale 設定対象ロケール文字列（enもしくはja）
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
