# frozen_string_literal: true

# Controller for homepage
class HomepageController < ApplicationController
  def index
    @course = Course.all.first
  end
end
