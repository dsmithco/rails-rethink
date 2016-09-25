class AddStyleToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :style, :hstore, default: {}, null: false
    add_index :attachments, :style, name: 'attachments_style_idx', using: :gin
  end
end
