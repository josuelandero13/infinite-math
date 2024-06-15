# frozen_string_literal: true

# Controller for homepage
class HomepageController < ApplicationController
  skip_before_action :protect_pages, only: %i[index]
  def index
    @course = Course.all.first
  end
end
