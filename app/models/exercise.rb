class Exercise < ApplicationRecord
  has_rich_text :content

  belongs_to :study_unit
end
