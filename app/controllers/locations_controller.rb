class LocationsController < ApplicationController
  before_action :set_location, only: %i[show update destroy]

  def index
    @locations = Location.all
    render json: @locations
  end

  def show
    render json: @location
  end

  def search_results(params)
    @locations = FindBySchedule.new(params).call
    render partial: 'shared/card', locals: { locations: @locations }
  end

  def create
    @location, success = Creator.new(location_params).call
    if success
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def update
    @location, success = Updater.new(location_params).call
    if success
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @location, success = Destroyer.new(location_params).call
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
