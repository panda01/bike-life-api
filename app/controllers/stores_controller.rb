class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

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
    ne_a = params[:ne].split(',')
    ne = {:lat => ne_a[0], :lng => ne_a[1]}

    sw_a = params[:sw].split(',')
    sw = {:lat => sw_a[0], :lng => sw_a[1]}

    @stores = Store.where(:latitude => sw[:lat]..ne[:lat], :longitude => sw[:lng]..ne[:lng])
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
