# -*- coding: utf-8 -*-

class Profile < ActiveRecord::Base
  belongs_to :user

  accepts_nested_attributes_for :user, allow_destroy: true

  def update_locale(val)
    if I18n::available_locales.include?(val.to_sym)
      self.update_attribute(:locale, val.to_s)
    end
  end
end
