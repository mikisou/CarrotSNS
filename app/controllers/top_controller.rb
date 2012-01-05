# -*- coding: utf-8 -*-

class TopController < ApplicationController
  skip_before_filter :login_required, only: [:index]

  def index
  end
end
