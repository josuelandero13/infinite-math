# frozen_string_literal: true

class Authentication::SessionsController < ApplicationController
  skip_before_action :protect_pages

  def new; end

  def create
    @user = User.find_by(
      'email = :login OR username = :login', {
        login: params[:login]
      }
    )

    create_redirection_params
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: t('.session_destroyed')
  end

  def create_redirection_params
    authenticated_user = @user&.authenticate(params[:password])

    return redirect_to new_session_path, alert: t('.invalid_login') unless authenticated_user

    session[:user_id] = @user.id
    redirect_to root_path, notice: t('.welcome_session')
  end
end
