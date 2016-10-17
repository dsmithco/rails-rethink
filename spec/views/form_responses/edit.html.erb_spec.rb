require 'rails_helper'

RSpec.describe "form_responses/edit", type: :view do
  before(:each) do
    @form_response = assign(:form_response, FormResponse.create!(
      :form => nil
    ))
  end

  it "renders the edit form_response form" do
    render

    assert_select "form[action=?][method=?]", form_response_path(@form_response), "post" do

      assert_select "input#form_response_form_id[name=?]", "form_response[form_id]"
    end
  end
end
