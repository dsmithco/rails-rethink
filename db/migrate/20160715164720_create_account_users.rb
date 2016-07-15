class CreateAccountUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :account_users do |t|
      t.string :role
      t.belongs_to :account, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    remove_column :users, :account_id, :number, index: true, foreign_key: true
  end
end
