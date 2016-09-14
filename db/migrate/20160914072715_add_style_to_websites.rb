class AddStyleToWebsites < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'hstore'
    add_column :websites, :style, :hstore, default: {}, null: false
    add_index :websites, :style, name: 'websites_style_idx', using: :gin
  end
end
