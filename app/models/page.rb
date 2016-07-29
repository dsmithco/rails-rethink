class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :scope => :website_id, use: [:slugged, :scoped, :history]

  belongs_to :website
  belongs_to :page, optional: true
  has_many :pages

  validates :website, presence: true

end
