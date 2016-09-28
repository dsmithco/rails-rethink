require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  before(:each) do
    @category = assign(:category, Category.create!(
      :name => "MyString",
      :about => "MyString",
      :category => nil
    ))
  end

  it "renders the edit category form" do
    render

    assert_select "form[action=?][method=?]", category_path(@category), "post" do

      assert_select "input#category_name[name=?]", "category[name]"

      assert_select "input#category_about[name=?]", "category[about]"

      assert_select "input#category_category_id[name=?]", "category[category_id]"
    end
  end
end
