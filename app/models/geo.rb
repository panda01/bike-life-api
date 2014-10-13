class Geo
  def initialize(ne, sw, classType=Store)
    ne_a = ne.split(',')
    @ne = {:lat => ne_a[0], :lng => ne_a[1]}

    sw_a = sw.split(',')
    @sw = {:lat => sw_a[0], :lng => sw_a[1]}
    @results = []
    @class_type = classType
  end

  def loadFromDb
    @results = @class_type.where(:latitude => @sw[:lat]..@ne[:lat], :longitude => @sw[:lng]..@ne[:lng])
  end

  # 1. Calls Foursquare bounded by NE & SW
  # 2. Formats results into DB schema
  # 3. Tries to insert into DB (fails on dupe foursquare ID)
  def checkFoursquare
    if @class_type != Store
      raise "Should only check Foursquare for Store model class"
    end
    fs_client = Foursquare2::Client.new(:client_id => FOURSQUARE['client_id'], :client_secret => FOURSQUARE['client_secret'], :intent => 'browse', :api_version => '20140806')

    options = { :ne => @ne[:lat] + ',' + @ne[:lng], :sw => @sw[:lat] + ',' + @sw[:lng] }
    options[:near] = 'New York, NY'
    options[:categoryId] = '4bf58dd8d48988d115951735,4e4c9077bd41f78e849722f9'

    fs_stores = fs_client.search_venues(options)
    formatted_stores = formatFoursquare(fs_stores)
    addNewFoursquarePlacesToDb(formatted_stores)
  end

  attr_reader :results

  private
  def addNewFoursquarePlacesToDb(fs_items)
    err = 0
    fs_items.each do |venue|
      # TODO I could add a cache so we don't try to insert dupes
      begin
        new_item = @class_type.create(venue)
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
end
