class RemoveWebsiteBlocks < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key "blocks", "websites"
    remove_index :blocks, [:website_id]
    remove_column :blocks, :website_id, :integer
    Page.all.each do |page|
      page.updated_at = Time.zone.now
      page.save!
      if page.image.present?
        top_block = page.blocks.new(page_id: page.id, block_type: 'custom', position: 1, name: page.name, bg_color: '#0c0c0c')
        top_block.save!
        Image.create(asset: page.image.asset, attachable_id: top_block.id, attachable_type: 'Block')
        page.update!(display_name: false)
      end
    end
  end
end
