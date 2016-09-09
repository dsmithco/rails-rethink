class AddTextAlignToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :text_align, :string
  end
end
