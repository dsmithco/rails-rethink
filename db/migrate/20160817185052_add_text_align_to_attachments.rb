class AddTextAlignToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :text_align, :string
  end
end
