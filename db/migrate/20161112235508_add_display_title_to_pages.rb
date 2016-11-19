class AddDisplayTitleToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :display_name, :boolean, default: true
  end
end
