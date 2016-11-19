class AddHomepagesToWebsites < ActiveRecord::Migration[5.0]
  def change
    Website.all.each do |website|
      if !website.pages.where(is_homepage: true).present?
        new_homepage = website.pages.create(
          is_homepage: true,
          website_id: website.id,
          show_in_menu: false
        )
        website.blocks.select{|b| !b.page_ids.present? }.each do |block|
          block.page_ids << new_homepage.id if !block.page_ids.include(new_homepage.id)
          block.front_page = false
          block.save
        end
      end
    end
  end
end
