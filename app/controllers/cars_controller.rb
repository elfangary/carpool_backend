class CarsController < ApplicationController
  def index
    @cars = current_user.cars
    render json: @cars, status: :ok
  end

  def show
    @car = Car.find params[:id]
    render json: @car, status: :ok
  end
end
