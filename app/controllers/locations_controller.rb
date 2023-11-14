class LocationsController < ApplicationController
  before_action :set_location, only: %i[show update destroy]

  def index
    @locations = LocationServices::Listener.new.call
    render json: @locations
  end

  def show
    @location = LocationServices::Shower.new(params[:id]).call
    render json: @location
  end

  def search_results
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"

    if params['[locations]'].present?
      @locations = LocationServices::FindBySchedule.new(params).call
    else
      @locations = LocationServices::Listener.new.call
    end

    render 'pages/home'
  end

  def create
    @location, success = LocationServices::Creator.new(location_params).call
    if success
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def update
    @location, success = LocationServices::Updater.new(location_params).call
    if success
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @location, success = LocationServices::Destroyer.new(location_params).call
    if success
      render json: { message: 'Location deleted' }, status: :ok
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Location not found' }, status: :not_found
  end

  def location_params
    params.require(:location).permit(:uuid, :title, :content, :opened, :mask,
                                     :towel, :fountain, :locker_room, :schedules,
                                     :street, :region, :city_name, :state_name, :uf)
  end
end
