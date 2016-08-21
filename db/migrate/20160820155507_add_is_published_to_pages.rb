class AddIsPublishedToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :is_published, :boolean, default: false, index: true
  end
end
