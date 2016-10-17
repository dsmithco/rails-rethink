class CreateAnswerQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_question_options do |t|
      t.belongs_to :answer, foreign_key: true
      t.belongs_to :question_option, foreign_key: true

      t.timestamps
    end
  end
end
