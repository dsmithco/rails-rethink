class HeroImage < Attachment

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :asset, styles: {
    thumb: '100x100>',
    medium: '300x300>',
    hero: '1400x600#'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/

  def thumb
    self.try(:asset, :thumb)
  end

  def medium
    self.try(:asset, :medium)
  end

  def hero
    self.try(:asset, :hero)
  end

  def as_json(options={})
    super(options.merge({:methods => [:thumb, :medium, :hero]}))
  end

end
