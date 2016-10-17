class AddEmailRecipientsToForms < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :email_recipients, :text
  end
end
