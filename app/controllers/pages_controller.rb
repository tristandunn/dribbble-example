class PagesController < ApplicationController
  def index
    if session[:token].present?
      @user = User.new(session[:token])
    end
  end
end
