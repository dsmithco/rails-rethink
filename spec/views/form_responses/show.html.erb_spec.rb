require 'rails_helper'

RSpec.describe "form_responses/show", type: :view do
  before(:each) do
    @form_response = assign(:form_response, FormResponse.create!(
      :form => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
