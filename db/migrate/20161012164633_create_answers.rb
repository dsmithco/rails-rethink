class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :answer_text
      t.belongs_to :form_response, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.text :question_json

      t.timestamps
    end
  end
end
