# -*- coding: utf-8 -*-

# ユーザーアカウントモデル
class User < ActiveRecord::Base
  # 検索可能なカラム名の配列（ユーザー一覧画面の検索フォームで使用する）
  SEARCHABLE_COLUMNS = [[I18n.t("activerecord.attributes.user.login"), :login],
                        [I18n.t("activerecord.attributes.user.email"), :email]]

  has_secure_password
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :password, presence: true,
                        length: {minimum: 5, maximum: 80},
                        on: :create
  validates :login, presence: true,
                     uniqueness: true,
                     length: {maximum: 20}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                                on: :create }

  # キーワード検索用スコープ
  # 対象カラムを限定し、意図しないカラムに対して検索が実行されないことを保証する。
  # TODO: 将来的には正規表現検索対応としたい(MySQL前提とすべきか)
  scope :search, lambda {|column, keyword|
    raise CarrotSns::InvalidColumnNameError unless SEARCHABLE_COLUMNS.map {|sc| sc.last }.include?(column.to_s.to_sym)
    where(arel_table[column.to_sym].matches("%#{keyword}%"))
  }
end
