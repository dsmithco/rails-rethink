class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :scope => :website_id, use: [:slugged, :scoped, :history]

  default_scope { order('pages.position ASC') }

  belongs_to :website
  belongs_to :page, optional: true
  has_many :page_blocks
  has_many :blocks, through: :page_blocks

  acts_as_list scope: [:website_id, :page_id]

  has_many :pages

  validates :website, presence: true

end
