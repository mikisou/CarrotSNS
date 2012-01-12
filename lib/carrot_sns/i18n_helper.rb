# -*- coding: utf-8 -*-

module CarrotSns
  module I18nHelper
    I18N_MESSAGES_PREFIX = "carrot_sns.messages"

    def model_t(model_name)
      return I18n.t("activerecord.models.#{model_name}")
    end

    def ar_t(model_name, attr_name, opts = {})
      default_value = opts[:default] || attr_name.capitalize

      return I18n.t("activerecord.attributes.#{model_name}.#{attr_name}",
                    default: I18n.t("attributes.#{attr_name}",
                                    default: I18n.t("activerecord.labels.#{attr_name}",
                                                    default: default_value)))
    end

    def i18n_t(category, name, opts = {})
      return I18n.t("#{I18N_MESSAGES_PREFIX}.#{category}.#{name}", opts)
    end
  end
end