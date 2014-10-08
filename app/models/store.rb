class Store < ActiveRecord::Base
  include Foursquare2 

  def initialize(client_id, client_secret)
    self.client = Foursquare2::Client.new(:client_id => FOURSQUARE['client_id'], :client_secret => FOURSQUARE['client_secret'])
  end

  def findNearbyShops(ne, sw)
  end
end
