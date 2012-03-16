# -*- coding: utf-8 -*-

# I18n用のロケール管理メソッドをまとめたモジュール
module CarrotSns
  module I18nLocale
    private

    # ロケール情報の設定
    #
    # I18nのロケール情報を設定する。引数が与えられなかった場合はセッション・パラメータ・
    # HTTP_ACCEPT_LANGUAGE値などを順に参照して表示すべきロケールを自動判定する。
    # @param [String] extracted_locale 設定するロケール文字列（jaもしくはen）
    # @return session[:locale]の値
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

    # ログイン中のユーザーのプロフィールに設定されたロケールを取得（優先順位：2位）
    # @return ロケール文字列
    def extract_locale_from_current_user
      if current_user
        return current_user.profile.locale
      end
    end

    # HTTPリクエストに含まれるサブドメイン名の取得（優先順位：6位）
    # @return ロケール文字列
    def extract_locale_from_subdomain
      request.subdomains.first
    end

    # HTTPリクエストに含まれるトップレベルドメイン名の取得（優先順位：7位）
    # @return ロケール文字列
    def extract_locale_from_tld
      request.domain.split('.').last
    end

    # HTTPリクエストのHTTP_ACCEPT_LANGUAGE値の取得（優先順位：5位）
    # @return ロケール文字列
    def extract_locale_from_accept_language
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end
end

