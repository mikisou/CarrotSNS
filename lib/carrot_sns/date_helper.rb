# -*- coding: utf-8 -*-

# 日時に関するヘルパメソッド群
module CarrotSns
  module DateHelper
    # 日時の文字列化を行う
    # @param [Time] t 処理対象となる時刻オブジェクト
    # @param [String] format フォーマット文字列。Time#strftimeに引き渡される。
    # @return 文字列化された時間
    def time_format(t, format = "%Y-%m-%d %H:%M:%S")
      return t.strftime(format)
    end

    # 日付のみの文字列化を行う
    # @param [Time || Date] d 処理対象となる日付または時刻オブジェクト
    # @param [String] format フォーマット文字列。
    # @return 文字列化された日付
    def date_format(d, format = "%Y-%m-%d")
      return d.strftime(format)
    end
  end
end