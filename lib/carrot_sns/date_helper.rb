# -*- coding: utf-8 -*-

module CarrotSns
  module DateHelper
    def time_format(t, format = "%Y-%m-%d %H:%M:%S")
      return t.strftime(format)
    end

    def date_format(d, format = "%Y-%m-%d")
      return d.strftime(format)
    end
  end
end