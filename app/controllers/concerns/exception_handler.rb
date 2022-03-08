module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |_e|
      render json: { error: 'Credentials are invalid!' }, status: :not_found
    end
    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: ErrorSerializer.json_invalid(e), status: :unprocessable_entity
    end
  end
end
