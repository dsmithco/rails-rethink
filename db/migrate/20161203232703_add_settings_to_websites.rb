class AddSettingsToWebsites < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :settings, :hstore, default: {}, null: false
  end
end
