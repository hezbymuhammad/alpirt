class Api::V1::SleepHistoriesController < ApplicationController
  before_action :set_user
  before_action :set_following_histories, only: [ :following ]
  before_action :set_histories, only: [ :index ]

  # POST /api/v1/users/:user_id/sleep_histories/sleep
  def sleep
    if @user.sleep
      render json: { message: "ok" }, status: 200
    else
      render json: { message: "failed" }, status: 400
    end
  end

  # POST /api/v1/users/:user_id/sleep_histories/wake_up
  def wake_up
    if @user.wake_up
      render json: { message: "ok" }, status: 200
    else
      render json: { message: "failed" }, status: 400
    end
  end

  # GET /api/v1/users/:user_id/sleep_histories
  def index
    render json: @histories, each_serializer: SleepHistorySerializer, status: :ok
  end

  # GET /api/v1/users/:user_id/sleep_histories/following
  def following
    render json: @following_histories, each_serializer: SleepHistorySerializer, include: ['user'], status: :ok
  end

  private

    def set_user
      @user = User.find_by_id params[:user_id]
      render json: { message: "user not found" }, status: 404 if @user.nil?
    end

    def set_histories
      @histories ||= @user.sleep_histories
                          .past_week
                          .page(page)
                          .per(per_page)
    end

    def set_following_histories
      @following_histories ||= SleepHistory.includes(:user)
                                           .for_users(@user.followings)
                                           .past_week
                                           .page(page)
                                           .per(per_page)
    end

    def page
      params[:page] || 1
    end

    def per_page
      params[:per_page] || 10
    end
end
