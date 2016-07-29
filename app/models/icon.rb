class Icon < Attachment

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :asset, styles: {
    medium: '300x300#'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.png\Z/

  def medium
    self.try(:asset, :medium)
  end

  def as_json(options={})
    super(options.merge({:methods => [:medium]}))
  end

end
