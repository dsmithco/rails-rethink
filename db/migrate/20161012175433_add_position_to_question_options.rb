class AddPositionToQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :question_options, :position, :integer
  end
end
