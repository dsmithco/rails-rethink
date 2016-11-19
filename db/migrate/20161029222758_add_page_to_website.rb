class AddPageToWebsite < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :is_homepage, :boolean, index: true
    add_index :pages, ["is_homepage"], name: "index_pages_on_is_homepage", using: :btree
    add_index :pages, ["website_id","is_homepage"], name: "index_pages_on_website_id_hp", using: :btree
  end
end
