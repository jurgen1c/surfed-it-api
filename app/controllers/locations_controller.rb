class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: %i[show update destroy]

  def index 
    @locations = current_user.locations
    render json: @locations, status: 200
  end

  def create
    @location = current_user.location.build!(location_params)
    render json: @location, status: 200
  end

  def show
    @location
    render json: @location, status: 200
  end

  def update
    @location.update(location_params)
    head :no_content
  end

  def destroy
    @location.destroy
    head :no_content
  end

  private
  def location_params
    params.permit(:name, :cover, :dificulty, :condition, :direction)
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def set_sessions
    
  end
end