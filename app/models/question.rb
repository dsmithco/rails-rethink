class Question < ApplicationRecord
  belongs_to :form
  has_many :answers
  has_many :question_options

  acts_as_list scope: [:form_id]

  default_scope { order('questions.position ASC') }


  accepts_nested_attributes_for :question_options, reject_if: proc { |attributes| attributes['name'].blank? }

  QUESTION_TYPES = %w{text_field text_area number email telephone true_false checkbox radio single_select multi_select none}

  validates :question_type, inclusion: { in: QUESTION_TYPES, message: "%{value} is not a valid option" }

end
