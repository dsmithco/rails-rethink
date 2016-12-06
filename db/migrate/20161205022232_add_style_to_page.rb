class AddStyleToPage < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :style, :hstore, default: {}, null: false
  end
end
