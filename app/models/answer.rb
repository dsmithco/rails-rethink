class Answer < ApplicationRecord
  belongs_to :form_response
  belongs_to :question

  has_many :answer_question_options
  has_many :question_options, through: :answer_question_options

  before_save :question_has_form
  before_save :set_question_json
  validates :question, presence: true

  private

  def question_has_form
    self.errors.add(:base, 'Question must be from form') unless self.question.form_id == self.form_response.form_id
  end

  def set_question_json
    self.question_json = self.question.to_json
  end

end
