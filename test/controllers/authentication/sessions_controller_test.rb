# frozen_string_literal: true

require 'test_helper'

# Test for sessions authentication
class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:josue)
  end

  test 'should get new' do
    get new_session_url
    assert_response :success
  end

  test 'should login an user by email' do
    post sessions_url, params: {
      login: @user.email,
      password: 'testme'
    }

    assert_redirected_to root_url
  end

  test 'should login an user by username' do
    post sessions_url, params: {
      login: @user.username,
      password: 'testme'
    }

    assert_redirected_to root_url
  end
end
