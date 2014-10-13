require 'test_helper'

class ParkingsControllerTest < ActionController::TestCase
  setup do
    @parking = parkings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parkings)
  end

  test "should show parking" do
    get :show, id: @parking
    assert_response :success
  end

  test "should get geo" do
    get :geo
    assert_response :success
  end

end
