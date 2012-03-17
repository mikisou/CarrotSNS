# -*- coding: utf-8 -*-

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  should belong_to :user

  should "have normal associations " do
  end
end
