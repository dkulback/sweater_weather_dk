class Api::V1::RoadTripController < ApplicationController
  before_action :authorize_user
  def create
    if @user
      trip = RoadTripServicer.road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.road_trip(trip), status: :ok
    else
      render json: { message: { error: 'Invalid or missing api key!' } }, status: :unauthorized
    end
  end

  private

  def authorize_user
    @user = User.find_by(api_key: params[:api_key])
  end
end
