# -*- coding: utf-8 -*-

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_one :profile

  should "check associations" do
  end
end
