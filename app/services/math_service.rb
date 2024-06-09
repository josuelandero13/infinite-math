# frozen_String_literal: true

require 'net/http'

# This class allows you to make requests to the mathjs API
class MathService
  attr_reader :expression

  def initialize(expression)
    @expression = expression
  end

  def calculate_derivative
    uri = URI('http://api.mathjs.org/v4/')
    request = build_post_request(uri, expression)
    response = execute_request(uri, request)
    process_response(response)
  end

  private

  def build_post_request(uri, expression)
    request = Net::HTTP::Post.new(uri, { 'Content-Type' => 'application/json' })
    request.body = { expr: "derivative('#{expression}', 'x')" }.to_json
    request
  end

  def execute_request(uri, request)
    Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(request)
    end
  end

  def process_response(response)
    response_suscces = { status: :ok, result: JSON.parse(response.body)['result'] }

    return response_suscces if response.is_a?(Net::HTTPSuccess)

    error_message = JSON.parse(response.body)['error'] || 'Error al calcular la derivada'
    { status: :unprocessable_entity, error: error_message }
  end
end
