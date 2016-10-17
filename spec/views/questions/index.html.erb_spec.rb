require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :name => "Name",
        :about => "MyText",
        :help => "MyText",
        :question_type => "Question Type",
        :is_required => false,
        :conditional_id => 2,
        :conditional_value => "MyText",
        :conditional_condition => "Conditional Condition",
        :position => 3
      ),
      Question.create!(
        :name => "Name",
        :about => "MyText",
        :help => "MyText",
        :question_type => "Question Type",
        :is_required => false,
        :conditional_id => 2,
        :conditional_value => "MyText",
        :conditional_condition => "Conditional Condition",
        :position => 3
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Question Type".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Conditional Condition".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
