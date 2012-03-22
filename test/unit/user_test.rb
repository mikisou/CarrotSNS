# -*- coding: utf-8 -*-

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_one :profile

  setup do
    @user_attr = {login: "testing", email: "dummy@localhost.local",
                  password: "testpassword", password_confirmation: "testpassword",
                  profile_attributes: {nick_name: "hide", age: 36,
                                       locale: "ja", comment: "test"}}
    @admin = FactoryGirl.create(:admin, password: 'monkey')
  end

  context "check login column" do
    should "can't create duplicated login name" do
      @user_attr.merge!(login: @admin.login)
      user = User.new(@user_attr)
      assert !user.save
      assert_equal 1, user.errors.size
      assert_equal [:login, "はすでに存在します。"], user.errors.first
    end

    should "login column required" do
      @user_attr.delete(:login)
      user = User.new(@user_attr)
      assert !user.save
      assert_equal 1, user.errors.size
      assert_equal [:login, "を入力してください。"], user.errors.first
    end

    should "login name no longer than 20 characters" do
      @user_attr.merge!(login: "test12345678901234567")
      user = User.new(@user_attr)
      assert !user.save
      assert_equal 1, user.errors.size
      assert_equal [:login, "は20文字以内で入力してください。"], user.errors.first
    end
  end

  context "check password column" do
    should "password column required" do
      @user_attr.delete(:password)
      user = User.new(@user_attr)
      assert !user.save
      assert_equal 4, user.errors.size
      errors_ary = ["パスワードが一致しません。",
                    "パスワードを入力してください。",
                    "パスワードは5文字以上で入力してください。",
                    "Password digestを入力してください。"]
      assert_equal errors_ary, user.errors.to_a
    end

    should "password no longer than 20 characters" do
      too_long_password = "a" + ("01234567890" * 8)
      @user_attr.merge!(password: too_long_password, password_confirmation: too_long_password)
      user = User.new(@user_attr)
      assert !user.save
      assert_equal 1, user.errors.size
      assert_equal [:password, "は80文字以内で入力してください。"], user.errors.first
    end
  end

  context "check email column" do
    should "unmatch bad email format" do
      @user_attr.merge!(email: "foo@local")
      user = User.new(@user_attr)
      assert !user.save
      expect_error = {email: ["は不正な値です。"]}
      assert_equal expect_error, user.errors.messages
    end

    should "unmatch email format nil" do
      @user_attr.delete(:email)
      user = User.new(@user_attr)
      assert !user.save
      expect_error = {email: ["は不正な値です。"]}
      assert_equal expect_error, user.errors.messages
    end
  end
end
