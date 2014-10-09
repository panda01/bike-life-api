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

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # GET /stores/geo/40.71/100.23
  def geo
    store_geo = Geo.new(params[:ne], params[:sw])
    
    # Load stores from DB
    store_geo.loadFromDb()
    store_geo.loadFromFoursquare()
    @stores = store_geo.stores[:db] + store_geo.stores[:foursquare]

  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
end

class Geo
  def initialize(ne, sw)
    ne_a = ne.split(',')
    @ne = {:lat => ne_a[0], :lng => ne_a[1]}

    sw_a = sw.split(',')
    @sw = {:lat => sw_a[0], :lng => sw_a[1]}
    @stores = {}
  end

  def loadFromDb
    puts @sw[:lat]
    @stores[:db] = Store.where(:latitude => @sw[:lat]..@ne[:lat], :longitude => @sw[:lng]..@ne[:lng])
  end

  def mergeFoursquareDb
    merged = []
    @stores[:db].each do |venue|
      if (@stores[:foursquareKeys][venue.foursquare_id])
        puts 'Removed a duplicate key'
        @stores[:foursquareKeys].delete(venue.foursquare_id)
      end
    end
    @stores[:merged] = @stores[:db] + @stores[:foursquareKeys].values
  end

  # returns hash where key is Foursquare PlaceID
  def formatFoursquare(stores)
    formatted = {}
    puts stores[:venues][0]
    stores[:venues].each do |venue|
      # TODO Is there a more compact way to pluck certain fields from an object?
      storeObj = {:id => venue.id, :name => venue.name, :phone => venue.contact.formattedPhone, :address => venue.location.address, :foursquare_id => venue.id, :hours => venue.hours, :latitude => venue.location.lat, :longitude => venue.location.lng, :website => venue.url }
      storeObj[:storetype] = venue.categories[0].id == '4e4c9077bd41f78e849722f9' ? 2 : 1 
      formatted[venue.id] = storeObj
    end
    @stores[:foursquareKeys] = formatted
    @stores[:foursquare] = formatted.values
  end

  def loadFromFoursquare
    fs_client = Foursquare2::Client.new(:client_id => FOURSQUARE['client_id'], :client_secret => FOURSQUARE['client_secret'], :intent => 'browse', :api_version => '20140806')

    options = { :ne => @ne[:lat] + ',' + @ne[:lng], :sw => @sw[:lat] + ',' + @sw[:lng] }
    options[:near] = 'New York, NY'
    options[:categoryId] = '4bf58dd8d48988d115951735,4e4c9077bd41f78e849722f9'

    fs_stores = fs_client.search_venues(options)
    formatFoursquare(fs_stores)
  end

  attr_reader :stores
end
