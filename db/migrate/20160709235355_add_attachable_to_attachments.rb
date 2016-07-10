class AddAttachableToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_reference :attachments, polymorphic: true, index: true
  end
end
