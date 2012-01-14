# -*- coding: utf-8 -*-

class UsersController < ApplicationController
  layout "application_no_sidebar"

  def index
    @users = User.order("created_at")

    if params.has_key?(:keyword) && !params[:keyword].empty?
      @users = @users.search(params[:column], params[:keyword])
    end

    @users = @users.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to @user, notice: i18n_t("notice", "successfully_created",
                                        name: model_t("user"))
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: i18n_t("notice", "successfully_updated",
                                        name: model_t("user"))
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url
  end
end
