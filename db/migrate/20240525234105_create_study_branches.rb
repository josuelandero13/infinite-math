class CreateStudyBranches < ActiveRecord::Migration[7.1]
  def change
    create_table :study_branches do |t|
      t.string :name

      t.timestamps
    end
  end
end
