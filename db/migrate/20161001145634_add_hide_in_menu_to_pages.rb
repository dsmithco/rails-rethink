class AddHideInMenuToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :hide_in_menu, :boolean, default: false
    add_column :pages, :redirectable_id, :integer
    add_column :pages, :redirectable_type, :string
    add_column :pages, :redirectable_url, :string

    add_index  :pages, ["redirectable_id", "redirectable_type"], name: "index_pages_on_redir_id_and_redir_type", using: :btree

  end
end
