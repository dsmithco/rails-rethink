class Website < ApplicationRecord
  belongs_to :account
  has_many :pages
  has_many :blocks
  has_one :logo, as: :attachable
  has_one :icon, as: :attachable
  has_many :hero_images, -> { order(position: :asc) }, as: :attachable
  has_many :images, as: :attachable

  validate :domain_url_uniqueness
  validates :account, presence: true

  def self.theme_options
    options = []
    Dir.glob("**/layouts/themes/*").each do |theme|
      theme_dirs = theme.split('/')
      theme_opt = theme_dirs[theme_dirs.length - 1]
      options << theme_opt
    end
    return options
  end

  validates :theme, inclusion: { in: Website.theme_options, message: "%{value} is not a valid theme" }

  after_save :push_changes

  attr_accessor :testing

  def push_changes
    puts "\n\n\n\n\n#{self.changes.to_json}\n\n\n\n\n"
  end

  def testing
    testing_will_change!
    "#{self.name.snakecase}_#{self.id.to_s}"
  end

  def rethink_url
    return "#{self.account_id}-#{self.id}.#{Rails.application.config.host_domain}"
  end

  def rethink_href
    return "//#{self.rethink_url}"
  end

  private

  def domain_url_uniqueness
    if self.domain_url.present?
      check_websites = Website.where('domain_url = ? OR domain_url = ? OR domain_url = ?',
                                     "#{self.domain_url}",
                                     "www.#{self.domain_url}",
                                     "#{self.domain_url.gsub('www.','')}")
      if check_websites.present?
        self.errors[:domain_url] << "#{self.domain_url} is already in use."
      end
    end
  end

end
