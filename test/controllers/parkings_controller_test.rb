require 'test_helper'

class ParkingsControllerTest < ActionController::TestCase
  setup do
    @rack = parkings(:rack)
    @shelter = parkings(:shelter)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parkings)
  end

  test "should show parking" do
    get :show, id: @rack
    assert_response :success
  end

  test "should failed on get geo without sw & ne" do
    assert_raises ActionController::ParameterMissing do
      get :geo
    end
  end

  test "should failed on get geo without sw" do
    assert_raises ActionController::ParameterMissing do
      get(:geo, {'ne' => "41,-74", 'format' => "json"})
    end
  end

  test "should failed on get geo without ne" do
    assert_raises ActionController::ParameterMissing do
      get(:geo, {'sw' => "41,-74", 'format' => "json"})
    end
  end

  test "should return only parkings in bounds on get geo" do
    get(:geo, {'sw' => "40,-75", 'ne' => "41,-74", 'format' => "json"})
    assert_response :success
    assert_equal assigns(:parkings).length, 1
    assert_equal assigns(:parkings).first, @rack
  end

  test "should return all parkings in extended bounds on get geo" do
    get(:geo, {'sw' => "40,-75", 'ne' => "41,-73", 'format' => "json"})
    assert_response :success
    assert_equal assigns(:parkings).length, 2
    assert_equal assigns(:parkings).first, @rack
    assert_equal assigns(:parkings).last, @shelter
  end
end
