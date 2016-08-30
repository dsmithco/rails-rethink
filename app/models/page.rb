class Page < ApplicationRecord
  logger = Page.logger

  extend FriendlyId
  friendly_id :name, :scope => :website_id, use: [:slugged, :scoped, :history]
  acts_as_list scope: [:website_id, :page_id]

  default_scope { order('pages.position ASC') }

  belongs_to :website
  belongs_to :page, optional: true, touch: true
  has_many :page_blocks, dependent: :destroy
  has_many :blocks, through: :page_blocks
  has_one :image, as: :attachable, dependent: :destroy
  has_many :pages

  validates :website, presence: true

  after_save :menu_setup


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

  def menu_setup
    logger.info "Checking nav for page #{self.id}"
    page_sub_nav = self.blocks.where(block_type: 'navigation')
    if self.needs_sub_menu && !page_sub_nav.present?
      self.add_sub_menu
    end
    if !self.needs_sub_menu
      self.remove_sub_menu
    end
  end

  def needs_sub_menu
    self.show_sub_menu && (self.page.present? || self.pages.present?)
  end

  def add_sub_menu
    website_nav = self.website.blocks.where(block_type: 'navigation').first
    if website_nav.present?
      logger.info "Nav found for page #{self.id}"
      PageBlock.create(page_id: self.id, block_id: website_nav.id)
    else
      logger.info "Creating new nav for page #{self.id}"
      self.blocks.create!(website_id: self.website_id, block_type: 'navigation', location: 'main_left')
    end
  end

  def remove_sub_menu
    sub_menu = self.blocks.where(block_type: 'navigation')
    if sub_menu.present?
      sub_menu.each do |menu|
        if menu.pages.count > 1
          menu.page_blocks.where(page_id: self.id).delete_all
        else
          menu.page_blocks.where(page_id: self.id).delete_all
          menu.destroy
        end
      end
    end
  end

end
