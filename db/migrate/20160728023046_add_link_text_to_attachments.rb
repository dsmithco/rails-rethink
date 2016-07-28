class AddLinkTextToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :link_text, :string
  end
end
