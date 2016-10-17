require 'rails_helper'

RSpec.describe "forms/show", type: :view do
  before(:each) do
    @form = assign(:form, Form.create!(
      :name => "Name",
      :about => "MyText",
      :description => "MyText",
      :is_published => false,
      :website => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
