class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.belongs_to :account, foreign_key: true
      t.string :name
      t.text :about
      t.string :domain_url
      t.string :google_analytics
      t.string :facebook
      t.string :twitter
      t.string :tags

      t.timestamps
    end
  end
end
