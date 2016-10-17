class AnswerQuestionOption < ApplicationRecord
  belongs_to :answer
  belongs_to :question_option

  validate :answer_has_question

  private

  def answer_has_question
    errors.add(:base, 'Answer must be from question') unless self.answer.question_id == self.question_option.question_id
  end

end
