class AddFieldsToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :name, :string
    add_column :attachments, :about, :string
    add_column :attachments, :link, :string
    add_column :attachments, :position, :integer
  end
end
