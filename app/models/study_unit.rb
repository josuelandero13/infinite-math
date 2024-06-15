class StudyUnit < ApplicationRecord
  has_rich_text :content

  validates :unit_number, numericality: {
    only_integer: true, message: 'only allows numbers.'
  }

  belongs_to :study_branch
end
