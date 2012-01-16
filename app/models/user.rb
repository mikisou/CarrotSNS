# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  SEARCHABLE_COLUMNS = [[I18n.t("activerecord.attributes.user.login"), :login],
                        [I18n.t("activerecord.attributes.user.email"), :email]]

  has_secure_password
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :password, presence: true, on: :create
  validates :login, presence: true, uniqueness: true

  scope :search, lambda {|column, keyword|
    where(arel_table[column.to_sym].matches("%#{keyword}%"))
  }
end
