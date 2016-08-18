class Attachment < ApplicationRecord

  belongs_to :attachable, :polymorphic => true

  TEXT_ALIGNMENTS = ['top left', 'top center', 'top right', 'middle left', 'middle center', 'middle right', 'bottom left', 'bottom center', 'bottom right']

  validates :text_align, inclusion: { in: TEXT_ALIGNMENTS + ['',nil], message: "%{value} is not a valid alignment" }

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :asset, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/

end
