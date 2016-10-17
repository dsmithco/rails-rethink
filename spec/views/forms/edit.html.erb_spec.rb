require 'rails_helper'

RSpec.describe "forms/edit", type: :view do
  before(:each) do
    @form = assign(:form, Form.create!(
      :name => "MyString",
      :about => "MyText",
      :description => "MyText",
      :is_published => false,
      :website => nil
    ))
  end

  it "renders the edit form form" do
    render

    assert_select "form[action=?][method=?]", form_path(@form), "post" do

      assert_select "input#form_name[name=?]", "form[name]"

      assert_select "textarea#form_about[name=?]", "form[about]"

      assert_select "textarea#form_description[name=?]", "form[description]"

      assert_select "input#form_is_published[name=?]", "form[is_published]"

      assert_select "input#form_website_id[name=?]", "form[website_id]"
    end
  end
end
