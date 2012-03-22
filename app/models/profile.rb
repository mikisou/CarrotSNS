# -*- coding: utf-8 -*-

# ユーザープロフィールモデル
class Profile < ActiveRecord::Base
  belongs_to :user

  accepts_nested_attributes_for :user, allow_destroy: true

  validates :nick_name, presence: true,
                         uniqueness: true,
                         length: {maximum: 90}
  validates :locale, presence: true,
                      :inclusion => { :in => ['ja', 'en'] }
  validates :age, numericality: true
  validates :comment, length: { maximum: (90 * 1024) }

  # プロフィールのロケール情報を変更
  # @param locale_val 変更後のロケール文字列（jaもしくはen）
  # @return nil
  def update_locale(locale_val)
    if I18n::available_locales.include?(locale_val.to_sym)
      self.update_attribute(:locale, locale_val.to_s)
    end
  end
end
