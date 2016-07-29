class ChangePositionToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :blocks, :position
    remove_column :page_blocks, :position
    remove_column :pages, :position
    add_column :blocks, :position, :integer, index: true
    add_column :page_blocks, :position, :integer, index: true
    add_column :pages, :position, :integer, index: true
  end
end
