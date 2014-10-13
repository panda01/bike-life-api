class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  include Foursquare2 

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/geo.json?sw=40,-74&ne=41,-73
  def geo
    store_geo = Geo.new(params[:ne], params[:sw], Store)
    
    # Load stores from DB
    store_geo.checkFoursquare()
    store_geo.loadFromDb()
    @stores = store_geo.results
  end
end

