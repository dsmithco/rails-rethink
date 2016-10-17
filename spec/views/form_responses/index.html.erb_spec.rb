require 'rails_helper'

RSpec.describe "form_responses/index", type: :view do
  before(:each) do
    assign(:form_responses, [
      FormResponse.create!(
        :form => nil
      ),
      FormResponse.create!(
        :form => nil
      )
    ])
  end

  it "renders a list of form_responses" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
