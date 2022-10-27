class Api::V1::BookSearchController < ApplicationController
  before_action :check_location, :get_coordinates
  def index
    forecast = ForecastServicer.forecast(@coordinates[:lat], @coordinates[:lng])
    books = BooksServicer.search_books(params[:location], params[:quantity])
    render json: BooksSerializer.books(forecast, books, params[:location]), status: :ok
  end

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
