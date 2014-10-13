require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
   test "should not save parking without lat & lng" do
       post = Parking.new
         assert_not post.save, "Saved the post without a latitude"
   end
end
