# frozen_string_literal: true

# Class to create sessions in the application
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
