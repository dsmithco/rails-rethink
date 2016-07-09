class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :foo, use: [:slugged, :finders]

  belongs_to :website
  belongs_to :page, optional: true
  has_many :pages
end
