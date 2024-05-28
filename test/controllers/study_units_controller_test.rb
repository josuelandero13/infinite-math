require "test_helper"

class StudyUnitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get study_units_index_url
    assert_response :success
  end
end
