class FormSubmitMailer < ApplicationMailer
  default :from => 'info@rethinkwebdesign.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.form_submit_mailer.send_results.subject
  #
  def send_results(form_response)
    @form_response = form_response

    mail to: "#{form_response.form.email_recipients}", subject: "#{form_response.form.name} submission"
  end
end
