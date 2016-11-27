class AddPageToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_reference :blocks, :page, foreign_key: true
    Website.all.each do |website|
      if !website.pages.where(is_homepage: true).present?
        new_homepage = website.pages.create(
          is_homepage: true,
          website_id: website.id,
          show_in_menu: false
        )
      end
    end
  end
end
