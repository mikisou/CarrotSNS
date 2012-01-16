# -*- coding: utf-8 -*-

# initialize App
require 'carrot_sns'

# Original Configurations
module CarrotSns
  class Application < Rails::Application
    config.avairable_languages = [["日本語", "ja"],
                                  ["English", "en"]]
  end
end
