class AddBlockIdToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_reference :blocks, :block, foreign_key: true
  end
end
