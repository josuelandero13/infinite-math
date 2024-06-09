# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def index; end

  def calculate
    result = MathService.new(params[:expression]).calculate_derivative

    return render json: { derivative: result[:result] } if result[:status] == :ok

    render json: { error: result[:error] }, status: :unprocessable_entity
  end
end
