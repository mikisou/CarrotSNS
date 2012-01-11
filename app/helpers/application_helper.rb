# -*- coding: utf-8 -*-

module ApplicationHelper
  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end

  include CarrotSns::DateHelper
  include CarrotSns::I18nHelper
end
