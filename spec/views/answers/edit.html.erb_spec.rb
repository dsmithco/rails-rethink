require 'rails_helper'

RSpec.describe "answers/edit", type: :view do
  before(:each) do
    @answer = assign(:answer, Answer.create!(
      :answer_text => "MyText",
      :form_response => nil,
      :question => nil,
      :question_json => "MyText"
    ))
  end

  it "renders the edit answer form" do
    render

    assert_select "form[action=?][method=?]", answer_path(@answer), "post" do

      assert_select "textarea#answer_answer_text[name=?]", "answer[answer_text]"

      assert_select "input#answer_form_response_id[name=?]", "answer[form_response_id]"

      assert_select "input#answer_question_id[name=?]", "answer[question_id]"

      assert_select "textarea#answer_question_json[name=?]", "answer[question_json]"
    end
  end
end
