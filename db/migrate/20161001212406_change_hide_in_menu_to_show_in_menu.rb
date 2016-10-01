class ChangeHideInMenuToShowInMenu < ActiveRecord::Migration[5.0]
  def change
    rename_column :pages, :hide_in_menu, :show_in_menu
    Page.where(show_in_menu: [false,nil]).update_all(show_in_menu: true)
  end
end
