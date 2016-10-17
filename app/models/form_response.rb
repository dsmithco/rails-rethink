class FormResponse < ApplicationRecord
  belongs_to :form
  has_many :answers

  accepts_nested_attributes_for :answers, allow_destroy: true#, reject_if: proc { |attributes| attributes['answer_text'].blank? }

  after_create :send_form_response_results

  private

  def send_form_response_results
    FormSubmitMailer.send_results(self).deliver_now if self.form.email_recipients.present?
  end

end
