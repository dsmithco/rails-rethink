require 'rails_helper'

RSpec.describe "FormResponses", type: :request do
  describe "GET /form_responses" do
    it "works! (now write some real specs)" do
      get form_responses_path
      expect(response).to have_http_status(200)
    end
  end
end
