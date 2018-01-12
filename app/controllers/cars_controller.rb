class CarsController < ApplicationController
  def index
    @cars = current_user.cars
    render json: @cars, status: :ok
  end

  def show
    @car = Car.find params[:id]
    render json: @car, status: :ok
  end

  def create
    @car = current_user.cars.new car_params
    if @car.save!
      render json: @car, status: :created
    else
      byebug
      render json: @car.errors, status: :unauthorized
    end
  end

  def destroy
    @car = Car.find params[:id]
    @car.destroy
    render json: { operation: 'OK' }, status: :ok
  end

  private
  def car_params
    params.permit(:model, :color, :number)
  end
end
