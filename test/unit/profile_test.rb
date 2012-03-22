# -*- coding: utf-8 -*-

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  should belong_to :user

  setup do
    @admin = FactoryGirl.create(:admin, password: 'monkey')
    @profile = Profile.create(nick_name: "foo", locale: "ja",
                              age: 33, comment: "bar",
                              user_id: @admin.id)
  end

  context "check nick_name column" do
    should "presence of" do
      profile = Profile.new
      assert !profile.save
      expect_errors = {nick_name: ["を入力してください。"],
                       age: ["は数値で入力してください。"]}
      assert_equal expect_errors, profile.errors.messages
    end

    should "uniqueness of" do
      profile = Profile.new(nick_name: "foo", locale: "ja", age: 34, comment: "baz")
      assert !profile.save
      expect_errors = {nick_name: ["はすでに存在します。"]}
      assert_equal expect_errors, profile.errors.messages
    end

    should "length of" do
      profile = Profile.new(nick_name: ("a" * 90),
                            locale: "ja", age: 34, comment: "baz")
      assert profile.save
      profile = Profile.new(nick_name: ("a" * 91),
                            locale: "ja", age: 34, comment: "baz")
      assert !profile.save
      expect_errors = {nick_name: ["は90文字以内で入力してください。"]}
      assert_equal expect_errors, profile.errors.messages
    end
  end

  context "check locale column" do
    should "presence of" do
      profile = Profile.new(locale: nil)
      assert !profile.save
      expect_errors = {nick_name: ["を入力してください。"],
                       locale: ["を入力してください。", "は一覧にありません。"],
                       age: ["は数値で入力してください。"]}
      assert_equal expect_errors, profile.errors.messages
    end

    should "inclusion of" do
      profile = Profile.new(nick_name: "foobar", locale: "de", age: 33, comment: "bar")
      assert !profile.save
      expect_errors = {locale: ["は一覧にありません。"]}
      assert_equal expect_errors, profile.errors.messages
    end
  end

  context "check age column" do
    should "numericality of" do
      profile = Profile.new(nick_name: "foobar", locale: "ja", age: "foo", comment: "bar")
      assert !profile.save
      expect_errors = {age: ["は数値で入力してください。"]}
      assert_equal expect_errors, profile.errors.messages
    end
  end

  context "check comment column" do
    should "length of" do
      profile = Profile.new(nick_name: "foo2", locale: "ja", age: 34,
                            comment: (("a" * 90) * 1024))
      assert profile.save
      profile = Profile.new(nick_name: "foo3", locale: "ja", age: 34,
                            comment: (("a" * 90) * 1024) + "a")
      assert !profile.save
      expect_errors = {comment: ["は#{90 * 1024}文字以内で入力してください。"]}
      assert_equal expect_errors, profile.errors.messages
    end
  end

  context "update_locale method" do
    should "success update locale" do
      assert @profile.update_locale(:en)
      assert_equal "en", @profile.locale

      assert @profile.update_locale(:ja)
      assert_equal "ja", @profile.locale
    end

    should "failed update locale" do
      assert !@profile.update_locale(:de)
      assert_equal "ja", @profile.locale
    end
  end
end
