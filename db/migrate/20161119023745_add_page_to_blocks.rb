class AddPageToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_reference :blocks, :page, foreign_key: true
    PageBlock.all.each do |page_block|
      page_block.block.update_columns(page_id: page_block.id)
    end
    Block.all.each do |block|
      if block.page_id.present?
        PageBlock.where(block_id: block.id).destroy
      end
    end
  end
end
