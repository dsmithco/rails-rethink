class CreateQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_options do |t|
      t.belongs_to :question, foreign_key: true
      t.string :name
      t.text :about
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
