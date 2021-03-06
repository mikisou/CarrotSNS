ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_filter_param(key)
    assert Rails.application.config.filter_parameters.include?(key.to_sym)
  end

  def assert_not_logged_in
    assert_response :redirect
    assert_redirected_to root_path
    msg = I18n.t("#{CarrotSns::I18nHelper::I18N_MESSAGES_PREFIX}.notice.login_required")
    assert_equal msg, flash[:error]
  end
end
