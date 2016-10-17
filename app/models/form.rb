class Form < ApplicationRecord
  belongs_to :website
  has_many :form_responses, dependent: :restrict_with_error
  has_many :questions
  has_many :formables, dependent: :restrict_with_error
  has_many :blocks

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  has_many :pages, through: :formable, source: :formable, source_type: 'Page'
  has_many :blocks, through: :formable, source: :formable, source_type: 'Block'

end
