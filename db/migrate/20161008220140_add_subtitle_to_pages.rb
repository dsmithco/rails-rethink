class AddSubtitleToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :subtitle, :string
    add_column :pages, :description, :text
    add_column :websites, :subtitle, :string
    add_column :categories, :subtitle, :string
    add_column :categories, :description, :text

  end
end
