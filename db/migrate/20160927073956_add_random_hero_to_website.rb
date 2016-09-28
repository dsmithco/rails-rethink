class AddRandomHeroToWebsite < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :random_hero, :boolean, default: false
  end
end
