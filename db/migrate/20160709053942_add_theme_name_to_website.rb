class AddThemeNameToWebsite < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :theme, :string, index: true
    add_index "websites", ["theme"], name: "index_websites_on_theme", using: :btree
    add_index "websites", ["name"], name: "index_websites_on_name", using: :btree
    add_index "websites", ["domain_url"], name: "index_websites_on_domain_url", using: :btree
    add_index "pages", ["name"], name: "index_pages_on_name", using: :btree
  end
end
