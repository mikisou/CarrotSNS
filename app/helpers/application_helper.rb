module ApplicationHelper
  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end

  def time_format(t, format = "%Y-%m-%d %H:%M:%S")
    return t.strftime(format)
  end

  def date_format(d, format = "%Y-%m-%d")
    return d.strftime(format)
  end
end
