require 'rails_helper'

RSpec.describe "questions/edit", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :name => "MyString",
      :about => "MyText",
      :help => "MyText",
      :question_type => "MyString",
      :is_required => false,
      :conditional_id => 1,
      :conditional_value => "MyText",
      :conditional_condition => "MyString",
      :position => 1
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "input#question_name[name=?]", "question[name]"

      assert_select "textarea#question_about[name=?]", "question[about]"

      assert_select "textarea#question_help[name=?]", "question[help]"

      assert_select "input#question_question_type[name=?]", "question[question_type]"

      assert_select "input#question_is_required[name=?]", "question[is_required]"

      assert_select "input#question_conditional_id[name=?]", "question[conditional_id]"

      assert_select "textarea#question_conditional_value[name=?]", "question[conditional_value]"

      assert_select "input#question_conditional_condition[name=?]", "question[conditional_condition]"

      assert_select "input#question_position[name=?]", "question[position]"
    end
  end
end
