class Api::V1::CirclesController < ApplicationController
  before_action :set_user
  before_action :set_target_user, only: [ :follow, :unfollow ]

  # GET /api/v1/users/:user_id/circles
  def index
    render json: followings, each_serializer: UserSerializer, adapter: :json_api, status: :ok
  end

  # PATCH /api/v1/users/:user_id/circles/follow
  def follow
    if @user.follow(@target_user)
      Rails.cache.delete("followings##{@user.id}")
      render json: { message: "ok" }, status: 200
    else
      render json: { message: "failed" }, status: 400
    end
  end

  # DELETE /api/v1/users/:user_id/circles/unfollow
  def unfollow
    if @user.unfollow(@target_user)
      Rails.cache.delete("followings##{@user.id}")
      render json: { message: "ok" }, status: 200
    else
      render json: { message: "failed" }, status: 400
    end
  end

  private

    def followings
      Rails.cache.fetch("followings##{@user.id}", expires_in: 12.hours) do
        @user.followings
      end
    end

    def set_user
      @user = User.find_by_id params[:user_id]
      render json: { message: "user not found" }, status: 404 if @user.nil?
    end

    def set_target_user
      @target_user = User.find_by_id params[:target_user_id]
      render json: { message: "target user not found" }, status: 404 if @target_user.nil?
    end
end
