class Website < ApplicationRecord
  belongs_to :account
  has_many :pages
  has_one :logo, as: :attachable
  has_one :icon, as: :attachable
  has_many :hero_images, as: :attachable
  has_many :images, as: :attachable

  validates :domain_url, uniqueness: true, allow_blank: true
  validates :account, presence: true

  after_save :push_changes

  attr_accessor :testing

  def push_changes
    puts "\n\n\n\n\n#{self.changes.to_json}\n\n\n\n\n"
  end

  def testing
    testing_will_change!
    "#{self.name.snakecase}_#{self.id.to_s}"
  end
end
