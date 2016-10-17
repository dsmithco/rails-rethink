require 'rails_helper'

RSpec.describe "questions/show", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :name => "Name",
      :about => "MyText",
      :help => "MyText",
      :question_type => "Question Type",
      :is_required => false,
      :conditional_id => 2,
      :conditional_value => "MyText",
      :conditional_condition => "Conditional Condition",
      :position => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Question Type/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Conditional Condition/)
    expect(rendered).to match(/3/)
  end
end
