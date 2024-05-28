class Course < ApplicationRecord
  has_many :course_branches, dependent: :restrict_with_exception
end
