class AddCssOverrideToWebsites < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :css_override, :text
  end
end
