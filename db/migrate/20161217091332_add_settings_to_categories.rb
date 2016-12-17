class AddSettingsToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :settings, :hstore, default: {}, null: false
  end
end
