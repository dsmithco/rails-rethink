class ChangePageToBlocks < ActiveRecord::Migration[5.0]
  def change

    PageBlock.all.each do |page_block|
      page_block.block.update_columns(page_id: page_block.page_id)
    end

    Block.all.each do |block|
      if block.front_page.present?
        block.page_id = Website.find(block.website_id).pages.where(is_homepage: true).first.id
        block.save!
      end
    end

    Website.all.each do |website|
      homepage = website.pages.where(is_homepage: true).first
      hero_block = Block.create!(block_type: 'hero_images', page_id: homepage.id, position: 1)
      website.hero_images.each do |hero|
        hero.attachable = hero_block
        hero.save!
      end
    end

  end
end
