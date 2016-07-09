class CreateBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :blocks do |t|
      t.string :name
      t.text :about
      t.belongs_to :website, foreign_key: true
      t.string :block_type
      t.string :position
      t.string :location

      t.timestamps
    end
  end
end
