# -*- coding: utf-8 -*-

# 国際化（I18n）関係のヘルパーメソッド群
module CarrotSns
  module I18nHelper
    I18N_MESSAGES_PREFIX = "carrot_sns.messages"

    # モデル名に対応するI18n文字列の取得
    # @param [String] model_name モデル名
    # @return 国際化されたモデル名の文字列
    def model_t(model_name)
      return I18n.t("activerecord.models.#{model_name}")
    end

    # モデルの属性名に対応するI18n文字列の取得
    # @param [String] model_name モデル名
    # @param [String] attr_name 属性名（カラム名）
    # @param [String] opts[:default] デフォルト値
    # @return 国際化された対応するモデル属性名の文字列
    def ar_t(model_name, attr_name, opts = {})
      default_value = opts[:default] || attr_name.capitalize

      return I18n.t("activerecord.attributes.#{model_name}.#{attr_name}",
                    default: I18n.t("attributes.#{attr_name}",
                                    default: I18n.t("activerecord.labels.#{attr_name}",
                                                    default: default_value)))
    end

    # 一般的な（本SNS固有の）I18n文字列の取得
    # @param [String] category I18N_MESSAGES_PREFIX で指定された階層直下のカテゴリ名
    # @param [String] name 取得対象のキー名
    # @param [Hash] opts I18n.tメソッドに渡すオプション用ハッシュ
    # @return 国際化された文字列
    def i18n_t(category, name, opts = {})
      return I18n.t("#{I18N_MESSAGES_PREFIX}.#{category}.#{name}", opts)
    end
  end
end