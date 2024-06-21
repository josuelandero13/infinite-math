# frozen_string_literal: true

# Add exercise reference to study unit
class AddStudyUnitToExercises < ActiveRecord::Migration[7.1]
  def change
    add_reference :exercises, :study_unit, foreign_key: true
  end
end
