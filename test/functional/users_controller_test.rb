# -*- coding: utf-8 -*-

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "GET index" do
    setup do
      @admin = FactoryGirl.create(:admin, password: 'monkey')
      session[:user_id] = @admin.id
    end

    context "without search keyword" do
      setup do
        get :index
      end
      should respond_with(:success)
      should render_template(:index)
      should render_with_layout
      should assign_to(:users).with_kind_of(ActiveRecord::Relation)
    end
  end


  test "should create user" do
#    assert_difference('User.count') do
#      post :create, user: @user.attributes
#    end

#    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
#    get :show, id: @user.to_param
#    assert_response :success
  end

  test "should get edit" do
#    get :edit, id: @user.to_param
#    assert_response :success
  end

  test "should update user" do
#    put :update, id: @user.to_param, user: @user.attributes
#    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
#    assert_difference('User.count', -1) do
#      delete :destroy, id: @user.to_param
#    end

#    assert_redirected_to users_path
  end
end
