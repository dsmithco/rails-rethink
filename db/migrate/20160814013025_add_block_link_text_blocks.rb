class AddBlockLinkTextBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :link, :string
    add_column :blocks, :link_text, :string
  end
end
