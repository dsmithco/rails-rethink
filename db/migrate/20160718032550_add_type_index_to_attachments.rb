class AddTypeIndexToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :attachable_id, :integer, index: true
    add_column :attachments, :attachable_type, :string, index: true
    add_index :attachments, [:type]
    add_index :attachments, [:attachable_id, :attachable_type]
    add_index :attachments, [:type, :attachable_id, :attachable_type]
  end
end
