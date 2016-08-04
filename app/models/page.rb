class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :scope => :website_id, use: [:slugged, :scoped, :history]

  default_scope { order('pages.position ASC') }

  belongs_to :website
  belongs_to :page, optional: true
  has_many :page_blocks, dependent: :destroy
  has_many :blocks, through: :page_blocks
  has_many :images, as: :attachable, dependent: :destroy

  acts_as_list scope: [:website_id, :page_id]

  has_many :pages

  validates :website, presence: true

  def main_left_blocks
    self.blocks.where(location: 'main_left')
  end

  def main_right_blocks
    self.blocks.where(location: 'main_right')
  end

  def main_top_blocks
    self.blocks.where(location: 'main_top')
  end

  def main_bottom_blocks
    self.blocks.where(location: 'main_bottom')
  end

  def top_blocks
    self.blocks.where(location: 'top')
  end

  def bottom_blocks
    self.blocks.where(location: 'bottom')
  end

end
