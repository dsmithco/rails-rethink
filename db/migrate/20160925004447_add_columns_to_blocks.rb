class AddColumnsToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :columns, :integer, default: 3
  end
end
