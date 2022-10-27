class Api::V1::ForecastController < ApplicationController
  before_action :check_location, :get_coordinates
  def index
    forecast = ForecastServicer.forecast(@coordinates[:lat], @coordinates[:lng])
    render json: ForecastSerializer.weather(forecast), status: :ok
  end

  private

  def get_coordinates
    @coordinates = GeocoderServicer.convert_location(params[:location])
  end

  def check_location
    if params[:location].nil? || params[:location].blank?
      render json: { error: 'Location parameter is required' },
             status: :bad_request
    end
  end
end
