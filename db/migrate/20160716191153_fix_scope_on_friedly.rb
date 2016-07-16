class FixScopeOnFriedly < ActiveRecord::Migration[5.0]
  def change
    remove_index :pages, [:slug]
    add_index    :pages, [:slug]
  end
end
