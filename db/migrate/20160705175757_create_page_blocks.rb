class CreatePageBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :page_blocks do |t|
      t.belongs_to :page, foreign_key: true
      t.belongs_to :block, foreign_key: true
      t.string :location
      t.string :position

      t.timestamps
    end
  end
end
