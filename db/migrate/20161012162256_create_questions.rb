class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.text :about
      t.text :help
      t.string :question_type
      t.boolean :is_required
      t.integer :conditional_id
      t.text :conditional_value
      t.string :conditional_condition
      t.integer :position
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
