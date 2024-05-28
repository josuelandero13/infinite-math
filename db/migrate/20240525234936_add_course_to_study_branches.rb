class AddCourseToStudyBranches < ActiveRecord::Migration[7.1]
  def change
    add_reference :study_branches, :course, foreign_key: true
  end
end
