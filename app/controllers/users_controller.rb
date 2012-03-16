# -*- coding: utf-8 -*-

# ユーザーアカウント管理用コントローラ
class UsersController < ApplicationController
  layout "application_no_sidebar"

  # ユーザーアカウント一覧画面
  def index
    @users = User.order("created_at")

    if params.has_key?(:keyword) && !params[:keyword].empty?
      @users = @users.search(params[:column], params[:keyword])
    end

    @users = @users.page(params[:page])
  end

  # 個別ユーザーの詳細情報表示画面
  def show
    @user = User.find(params[:id])
  end

  # 新規ユーザー登録フォーム画面
  def new
    @user = User.new
    @user.profile = Profile.new
  end

  # 既存ユーザー編集フォーム画面
  def edit
    @user = User.find(params[:id])
  end

  # 新規ユーザー登録実行
  def create
    @user = User.new(params[:user])

    unless @user.profile
      flash[:error] = i18n_t("error", "not_exist",
                             name: i18n_t("label", "profile"))
      redirect_to users_path
      return false
    end

    if @user.save
      redirect_to @user, notice: i18n_t("notice", "successfully_created",
                                        name: model_t("user"))
    else
      render action: "new"
    end
  end

  # 既存ユーザー情報更新実行
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: i18n_t("notice", "successfully_updated",
                                        name: model_t("user"))
    else
      render action: "edit"
    end
  end

  # 強制退会（ユーザーアカウント削除）実行
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end
end
