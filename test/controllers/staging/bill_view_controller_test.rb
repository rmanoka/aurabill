require 'test_helper'

class Staging::BillViewControllerTest < ActionController::TestCase
  test "should get empty_bill" do
    get :empty_bill
    assert_response :success
  end

end
