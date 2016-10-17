require 'rails_helper'

RSpec.describe "answers/show", type: :view do
  before(:each) do
    @answer = assign(:answer, Answer.create!(
      :answer_text => "MyText",
      :form_response => nil,
      :question => nil,
      :question_json => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
