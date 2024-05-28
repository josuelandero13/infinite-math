class AddStudyBranchToStudyUnits < ActiveRecord::Migration[7.1]
  def change
    add_reference :study_units, :study_branch, foreign_key: true
  end
end
