class Website < ApplicationRecord
  belongs_to :account
  has_many :pages
  has_one :logo, as: :attachable
  has_one :icon, as: :attachable
  has_many :hero_images, as: :attachable
  has_many :images, as: :attachable

  validates :domain_url, uniqueness: true, allow_blank: true
  validates :account, presence: true

  accepts_nested_attributes_for :logo
end
