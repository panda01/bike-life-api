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
    store_geo.checkFoursquare()
    store_geo.loadFromDb()
#    @stores = store_geo.stores[:db]
    puts @stores
    @stores = store_geo.stores[:db]

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
    @stores[:db] = Store.where(:latitude => @sw[:lat]..@ne[:lat], :longitude => @sw[:lng]..@ne[:lng])
  end

  def addNewFoursquarePlacesToDb(fs_items)
    err = 0
    fs_items.each do |venue|
      # TODO I could add a cache so we don't try to insert dupes
      begin
        @store = Store.create(venue)
      rescue => exception
        puts "Error adding foursquare venue #{exception}"
        err += 1
      end
    end
    puts "Completed with #{err} errors"
  end

  # Returns array of store schema hashes
  def formatFoursquare(stores)
    formatted = []
    stores[:venues].each do |venue|
      # TODO Is there a more compact way to pluck certain fields from an object?
      storeObj = {:name => venue.name, :phone => venue.contact.formattedPhone, :address => venue.location.address, :foursquare_id => venue.id, :hours => venue.hours, :latitude => venue.location.lat, :longitude => venue.location.lng, :website => venue.url }
      storeObj[:storetype] = venue.categories[0].id == '4e4c9077bd41f78e849722f9' ? 2 : 1 
      formatted.push(storeObj)
    end
    return formatted
  end

  # 1. Calls Foursquare bounded by NE & SW
  # 2. Formats results into DB schema
  # 3. Tries to insert into DB (fails on dupe foursquare ID)
  def checkFoursquare
    fs_client = Foursquare2::Client.new(:client_id => FOURSQUARE['client_id'], :client_secret => FOURSQUARE['client_secret'], :intent => 'browse', :api_version => '20140806')

    options = { :ne => @ne[:lat] + ',' + @ne[:lng], :sw => @sw[:lat] + ',' + @sw[:lng] }
    options[:near] = 'New York, NY'
    options[:categoryId] = '4bf58dd8d48988d115951735,4e4c9077bd41f78e849722f9'

    fs_stores = fs_client.search_venues(options)
    formatted_stores = formatFoursquare(fs_stores)
    addNewFoursquarePlacesToDb(formatted_stores)
  end

  attr_reader :stores
end
