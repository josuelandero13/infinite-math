class StudyUnit < ApplicationRecord
  has_rich_text :content

  belongs_to :study_branch
end
