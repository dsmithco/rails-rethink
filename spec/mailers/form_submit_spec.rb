require "rails_helper"

RSpec.describe FormSubmitMailer, type: :mailer do
  describe "send_results" do
    let(:mail) { FormSubmitMailer.send_results }

    it "renders the headers" do
      expect(mail.subject).to eq("Send results")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
