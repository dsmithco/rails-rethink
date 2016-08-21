class AddShowSubMenuToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :show_sub_menu, :boolean, default: true, index: true
  end
end
