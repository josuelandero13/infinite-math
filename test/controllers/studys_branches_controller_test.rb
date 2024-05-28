require "test_helper"

class StudysBranchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get studys_branches_index_url
    assert_response :success
  end
end
