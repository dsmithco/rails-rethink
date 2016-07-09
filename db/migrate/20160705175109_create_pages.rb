class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :name
      t.text :about
      t.belongs_to :website, foreign_key: true
      t.string :position
      t.belongs_to :page, foreign_key: true

      t.timestamps
    end
  end
end
