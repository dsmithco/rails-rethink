class Image < Attachment

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :asset, styles: {
    thumb: '200x200#',
    medium: '1000x400#',
    large: '1600x1600>',
    long: '1400x300#'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/

  def thumb
    self.try(:asset, :thumb)
  end

  def medium
    self.try(:asset, :medium)
  end

  def large
    self.try(:asset, :large)
  end

  def long
    self.try(:asset, :long)
  end

  def as_json(options={})
    super(options.merge({:methods => [:thumb, :medium, :large]}))
  end

end
