class Block < ApplicationRecord
  belongs_to :website, optional: true
  acts_as_list scope: [:website_id, :location, :block_id]

  default_scope { order('blocks.position ASC') }

  has_many :page_blocks
  has_many :pages, through: :page_blocks
  has_one :image, as: :attachable
  has_many :blocks
  belongs_to :block

  BLOCK_TYPES = ['custom', 'navigation', 'container', 'sub_block']
  CONTENT_REGIONS = ['main_top', 'main_bottom']
  WIDE_REGIONS = ['top', 'bottom']
  SIDE_REGIONS = ['main_left', 'main_right']
  REGIONS = CONTENT_REGIONS + WIDE_REGIONS + SIDE_REGIONS

  validates :block_type, inclusion: { in: BLOCK_TYPES, message: "%{value} is not a valid block type" }
  validates :location, inclusion: { in: REGIONS + [''], message: "%{value} is not a valid location" }

  validate :block_validation

  before_validation :adjust_block_params

  def block_validation
    if CONTENT_REGIONS.include?(self.block_type) && ['container'].include?(self.location)
      self.errors[:block_type] << " invalid block type and location combo"
    end
  end

  def as_json(options={})
    super(options.merge({:methods => [:page_ids]}))
  end

  private

  def adjust_block_params
    if self.block_id.present?
      self.block_type = 'sub_block'
      self.location = ''
      self.page_ids = []
      self.front_page = false
    end
  end

end
