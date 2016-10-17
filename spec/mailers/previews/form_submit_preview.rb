# Preview all emails at http://localhost:3000/rails/mailers/form_submit
class FormSubmitPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/form_submit/send_results
  def send_results
    FormSubmitMailer.send_results
  end

end
