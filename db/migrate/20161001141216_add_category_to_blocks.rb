class AddCategoryToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_reference :blocks, :category, foreign_key: true, index: true
  end
end
