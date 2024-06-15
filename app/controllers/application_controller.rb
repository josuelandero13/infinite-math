# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Language
  include Authentication
end
