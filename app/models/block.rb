class Block < ApplicationRecord
  belongs_to :website, optional: true
  acts_as_list scope: [:website_id, :location, :block_id]

  default_scope { order('blocks.position ASC') }

  has_many :page_blocks, dependent: :destroy
  has_many :pages, through: :page_blocks
  has_one :image, as: :attachable
  has_many :blocks
  belongs_to :block

  SYSTEM_BLOCK_TYPES = ['navigation']
  BLOCK_TYPES = ['custom', 'container', 'sub_block']
  CONTENT_REGIONS = ['top', 'bottom']
  SIDE_REGIONS = ['left', 'right']
  REGIONS = CONTENT_REGIONS + SIDE_REGIONS

  attr_accessor :continue_edit

  validates :block_type, inclusion: { in: BLOCK_TYPES + SYSTEM_BLOCK_TYPES, message: "%{value} is not a valid block type" }
  validates :location, inclusion: { in: REGIONS + [''], message: "%{value} is not a valid location" }

  validate :block_validation

  before_validation :adjust_block_params

  def block_validation
    if CONTENT_REGIONS.include?(self.block_type) && ['container'].include?(self.location)
      self.errors[:block_type] << " invalid block type and location combo"
    end
    if self.block_type == 'sub_block' && !self.block.present?
      self.errors[:block] << "Block is required"
    end
    if !self.block_id.present? && !self.pages.present?
      self.errors[:block] << "Block or page required"
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
