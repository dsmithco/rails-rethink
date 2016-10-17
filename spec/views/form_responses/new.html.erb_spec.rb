require 'rails_helper'

RSpec.describe "form_responses/new", type: :view do
  before(:each) do
    assign(:form_response, FormResponse.new(
      :form => nil
    ))
  end

  it "renders new form_response form" do
    render

    assert_select "form[action=?][method=?]", form_responses_path, "post" do

      assert_select "input#form_response_form_id[name=?]", "form_response[form_id]"
    end
  end
end
