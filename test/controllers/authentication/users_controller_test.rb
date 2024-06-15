# frozen_string_literal: true

require 'test_helper'

# Test for user authentication
class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: {
        email: 'maria@infinite.com',
        username: 'maria1397',
        password: 'testme'
      } }
    end

    assert_redirected_to root_path
  end

  test 'should not create user with invalid params' do
    assert_no_difference('User.count') do
      post users_url, params: {
        user: { email: '', username: '', password: '' }
      }
    end

    assert_response :unprocessable_entity
    assert_select 'div#error_explanation'
  end
end
