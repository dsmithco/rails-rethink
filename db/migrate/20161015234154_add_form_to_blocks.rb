class AddFormToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_reference :blocks, :form, foreign_key: true
  end
end
