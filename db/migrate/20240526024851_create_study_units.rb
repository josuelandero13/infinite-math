class CreateStudyUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :study_units do |t|
      t.integer :unit_number
      t.string :name

      t.timestamps
    end
  end
end
