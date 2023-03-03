class PagesController < ApplicationController
  def home
    @posts = current_user && current_user.feeds(params) || []
  end
end
