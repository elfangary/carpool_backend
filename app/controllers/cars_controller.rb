class CarsController < ApplicationController
  before_action :set_user

  def index
    @cars = @user.cars

    render json: @cars, status: :ok
  end

  def show
    @car = Car.find params[:id]

    render json: @car, status: :ok
  end

  private
  def set_user
    @user = User.find params[:user_id]
  end
end
