class Icon < Attachment

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :asset, styles: {
    medium: ['300x300#', :png],
    small: ['128x128#', :png]
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/

  def medium
    self.try(:asset, :medium)
  end

  def as_json(options={})
    super(options.merge({:methods => [:medium]}))
  end

end
