# frozen_String_literal: true

require 'test_helper'

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_path

    assert_response :success
    assert_select 'main'
  end
end
