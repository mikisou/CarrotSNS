# -*- coding: utf-8 -*-

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user_attr = {login: "testing", email: "dummy@localhost.local",
                    password: "testpassword", password_confirmation: "testpassword",
                    profile_attributes: {nick_name: "hide", age: 36,
                                           locale: "ja", comment: "test"}}
  end

  # 非ログイン状態
  context "without login" do
    setup do
      @admin = FactoryGirl.create(:admin, password: 'monkey')
    end

    should "GET index" do
      get :index
      assert_not_logged_in
      get :index, column: "foo", keyword: "bar"
      assert_not_logged_in
    end

    should "GET show" do
      get :show, id: @admin.id
      assert_not_logged_in
    end

    should "GET new" do
      get :new
      assert_not_logged_in
    end

    should "GET edit" do
      get :edit, id: @admin.id
      assert_not_logged_in
    end

    should "POST create" do
      post :create, user: @user_attr
      assert_not_logged_in
    end

    should "PUT update" do
      put :update, user: @user_attr
      assert_not_logged_in
    end

    should "DELETE destroy" do
      delete :destroy, id: @admin.id
      assert_not_logged_in
    end
  end


  # ログイン状態
  context "with login" do
    setup do
      @admin = FactoryGirl.create(:admin, password: 'monkey')
      @users = []
      5.times { @users << FactoryGirl.create(:user, password: 'monkey') }
      session[:user_id] = @admin.id
    end

    context "GET index" do
      should "without search keyword" do
        get :index
        users = assigns(:users)
        assert_response :success
        assert_template "index"
        assert_equal ActiveRecord::Relation, users.class
        assert_equal 5, users.size
        assert_equal User.order("created_at").all[0..4], users
        assert flash.empty?
        assert_filter_param(:password)
      end

      should "with search keyword for 'login' column" do
        get :index, column: 'login', keyword: 'admin'
        users = assigns(:users)
        assert_response :success
        assert_template "index"
        assert_equal ActiveRecord::Relation, users.class
        assert_equal 1, users.size
        assert_equal [User.find(@admin.id)], users
        assert flash.empty?
        assert_filter_param(:password)
      end

      should "with search keyword for 'email' column" do
        get :index, column: 'email', keyword: 'carrot_admin'
        users = assigns(:users)
        assert_response :success
        assert_template "index"
        assert_equal ActiveRecord::Relation, users.class
        assert_equal 1, users.size
        assert_equal [User.find(@admin.id)], users
        assert flash.empty?
        assert_filter_param(:password)
      end

      should "with search keyword for prohibition column" do
        assert_raise(CarrotSns::InvalidColumnNameError) do
          get :index, column: 'created_at', keyword: 'carrot_admin'
        end

        assert_raise(CarrotSns::InvalidColumnNameError) do
          get :index, column: nil, keyword: 'carrot_admin'
        end

        assert_raise(CarrotSns::InvalidColumnNameError) do
          get :index, column: '', keyword: 'carrot_admin'
        end
      end
    end


    context "POST create" do
      should "create successfully" do
        assert_difference('User.count') do
          post :create, user: @user_attr
        end
        assert_redirected_to user_path(assigns(:user))
      end
    end

    context "GET show" do
      should "show user successfully" do
        get :show, id: @admin.id
        assert_response :success
        assert_template 'show'
      end
    end

    context "GET new" do
      should "get new user form successfully" do
        get :new
        assert_response :success
        assert_template 'new'
      end
    end

    context "GET edit" do
      should "get edit form successfully" do
        get :edit, id: @admin.id
        assert_response :success
        assert_template 'edit'
      end
    end

    context "PUT update" do
      should "update user successfully" do
        put :update, id: @admin.id, user: @user_attr
        assert_redirected_to user_path(assigns(:user))
      end
    end

    context "DELETE destroy" do
      should "delete user successfully" do
        assert_difference('User.count', -1) do
          delete :destroy, id: @admin.id
        end
        assert_redirected_to users_path
      end
    end
  end
end
