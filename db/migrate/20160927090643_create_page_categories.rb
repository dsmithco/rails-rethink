class CreatePageCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :page_categories do |t|
      t.belongs_to :page, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.timestamps
    end
  end
end
