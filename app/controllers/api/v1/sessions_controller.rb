class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      render json: UsersSerializer.user(user), status: :ok
    else
      render json: { message: { error: 'Invalid credentials!!' } }, status: :unprocessable_entity
    end
  end
end
