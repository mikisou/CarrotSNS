# -*- coding: utf-8 -*-

module CarrotSns
  module I18nLocale
    private

    def set_locale(extracted_locale = nil)
      extracted_locale ||= (extract_locale_from_current_user ||
                            session[:locale] ||
                            params[:locale] ||
                            extract_locale_from_accept_language ||
                            extract_locale_from_subdomain ||
                            extract_locale_from_tld)

      if I18n::available_locales.include?(extracted_locale.to_sym)
        I18n.locale = extracted_locale
        session[:locale] = extracted_locale
      else
        I18n.locale = I18n.default_locale
        session[:locale] = nil
      end
    end

    def extract_locale_from_current_user
      if current_user
        return current_user.profile.locale
      end
    end

    def extract_locale_from_subdomain
      request.subdomains.first
    end

    def extract_locale_from_tld
      request.domain.split('.').last
    end

    def extract_locale_from_accept_language
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end
end

