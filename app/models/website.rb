class Website < ApplicationRecord
  belongs_to :account
  has_many :pages
  has_many :blocks
  has_one :logo, as: :attachable
  has_one :icon, as: :attachable
  has_many :hero_images, -> { order(position: :asc) }, as: :attachable
  has_many :images, as: :attachable

  validates :domain_url, uniqueness: true, allow_blank: true
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

end
