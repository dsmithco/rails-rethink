class Logo < Attachment


  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :asset, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '700x700>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/

end