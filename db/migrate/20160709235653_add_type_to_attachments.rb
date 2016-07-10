class AddTypeToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :type, :string, index: true
  end
end
