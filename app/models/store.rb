class Store < ActiveRecord::Base
  include Foursquare2 

  def initialize()
  end

  def findNearbyShops(ne, sw)
    # check DB for stores
    self.client = Foursquare2::Client.new(:client_id => FOURSQUARE['client_id'], :client_secret => FOURSQUARE['client_secret'])
  end
end
