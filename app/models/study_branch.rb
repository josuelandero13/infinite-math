class StudyBranch < ApplicationRecord
  belongs_to :course
  has_many :study_units, dependent: :restrict_with_exception
end
