# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, on: :create
  validates :login, presence: true, uniqueness: true

  paginates_per 5
end
