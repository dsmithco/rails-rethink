require 'rails_helper'

RSpec.describe "forms/index", type: :view do
  before(:each) do
    assign(:forms, [
      Form.create!(
        :name => "Name",
        :about => "MyText",
        :description => "MyText",
        :is_published => false,
        :website => nil
      ),
      Form.create!(
        :name => "Name",
        :about => "MyText",
        :description => "MyText",
        :is_published => false,
        :website => nil
      )
    ])
  end

  it "renders a list of forms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
