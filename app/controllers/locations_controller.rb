class LocationsController < ApplicationController
  before_action :set_location, only: [:show]

  def index
    @locations = Location.all
    render json: @locations
  end

  def show
    render json: @location
  end

  private
  def set_location
    @location = Location.find params[:id]
  end
end
