# frozen_string_literal: true

# Migration to create the exercise model
class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :title
      t.string :correct_answer

      t.timestamps
    end
  end
end
