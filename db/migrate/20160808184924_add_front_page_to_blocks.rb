class AddFrontPageToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :front_page, :boolean
  end
end
