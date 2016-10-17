class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :name
      t.text :about
      t.text :description
      t.datetime :open_at
      t.datetime :close_at
      t.boolean :is_published
      t.belongs_to :website, foreign_key: true

      t.timestamps
    end
  end
end
