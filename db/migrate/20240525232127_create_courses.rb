# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :score

      t.timestamps
    end
  end
end
