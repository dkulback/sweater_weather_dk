class Api::V1::BackgroundsController < ApplicationController
  before_action :check_location
  def index
    backgrounds = BackgroundsClient.get_background(params[:location])
    render json: BackgroundsSerializer.photo(backgrounds, params[:location]), status: :ok
  end
end
