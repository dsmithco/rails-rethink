class AddWebsiteToCategories < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :website, foreign_key: true, index: true
  end
end
