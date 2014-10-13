class ParkingsController < ApplicationController
  before_action :set_parking, only: [:show]

  # GET /parkings
  # GET /parkings.json
  def index
    @parkings = Parking.all
  end

  # GET /parkings/1
  # GET /parkings/1.json
  def show
  end

  # GET /parkings/geo.json?sw=40,-74&ne=41,-73
  def geo
    parking_geo = Geo.new(params[:ne], params[:sw], Parking)
    
    # Load stores from DB
    parking_geo.loadFromDb()
    @parkings = parking_geo.results
  end

end
