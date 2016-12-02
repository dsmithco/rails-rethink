class AddStyleToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :style, :hstore, default: {}, null: false
  end
end
