class AddBgColorToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :bg_color, :string
  end
end
