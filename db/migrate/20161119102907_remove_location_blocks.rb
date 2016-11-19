class RemoveLocationBlocks < ActiveRecord::Migration[5.0]
  def change
    remove_column :blocks, :location, :string
    drop_table :page_blocks
    Page.all.each do |page|
      page.blocks.create(block_type: 'page_content', about: page.about, position: 2)
    end
  end
end
