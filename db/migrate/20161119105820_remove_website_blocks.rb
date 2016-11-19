class RemoveWebsiteBlocks < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key "blocks", "websites"
    remove_index :blocks, [:website_id]
    remove_column :blocks, :website_id, :integer
  end
end
