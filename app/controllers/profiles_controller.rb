class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show]

  def show
  end

  def my
    @posts = current_user.ordered_posts(params)
  end

  # Method: POST
  def follow
    user = User.find(params[:user_id])
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to profile_url(user.id) }
      format.json { render json: { message: "Success" }, status: :created }
    end
  end

  private

  def set_profile
    @user = User.find(params[:id])
  end

end
