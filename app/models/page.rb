class Page < ApplicationRecord
  logger = Page.logger
  self.per_page = 5
  extend FriendlyId
  friendly_id :name, :scope => :website_id, use: [:slugged, :scoped, :history]
  acts_as_list scope: [:website_id, :page_id]

  default_scope { order('pages.position ASC') }

  belongs_to :website
  belongs_to :page, optional: true, touch: true
  has_many :blocks, dependent: :destroy
  has_one :image, as: :attachable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :pages
  has_many :page_categories, dependent: :destroy
  has_many :categories, through: :page_categories

  has_one :formable, as: :formable
  has_one :form, through: :formable

  validates :website, presence: true

  before_save :set_homepage
  after_save :submit_sitemaps
  after_save :update_content_block

  def cache_on
    [self, self.pages, self.page, self.categories, self.blocks, self.website, self.attachments]
  end

  def submit_sitemaps
    self.website.submit_sitemaps
  end

  handle_asynchronously :submit_sitemaps

  private

  def set_homepage
    if self.is_homepage == true && self.is_homepage_changed?
      self.website.pages.where(is_homepage: true).update_all(is_homepage: false)
    end
  end

  def update_content_block
    content_block = self.blocks.where(block_type: 'page_content').first
    if content_block.present?
      if self.about_changed? || self.name_changed?
        content_block.update_columns(about: self.about, name: self.name, updated_at: Time.zone.now)
      end
    else
      self.blocks.create(block_type: 'page_content', about: self.about, position: 2)
    end
  end

end
