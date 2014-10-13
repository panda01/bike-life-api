require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  setup do
    @one = stores(:one)
    @two = stores(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @one
    assert_response :success
  end

  test "should get geo" do
    get :geo
    assert_response :success
  end

end
