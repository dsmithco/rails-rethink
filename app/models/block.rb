class Block < ApplicationRecord
  belongs_to :website, optional: true
  acts_as_list scope: [:website_id, :location, :block_id]

  default_scope { order('blocks.position ASC') }

  has_many :page_blocks, dependent: :destroy
  has_many :pages, through: :page_blocks
  has_one :image, as: :attachable
  has_many :blocks
  belongs_to :block

  TEXT_ALIGN_OPTIONS = ['left','right','center','justify']
  SYSTEM_BLOCK_TYPES = ['navigation']
  BLOCK_TYPES = ['custom', 'container', 'sub_block']
  CONTENT_REGIONS = ['top', 'bottom']
  SIDE_REGIONS = ['left', 'right']
  REGIONS = CONTENT_REGIONS + SIDE_REGIONS

  attr_accessor :continue_edit

  validates :text_align, inclusion: { in: TEXT_ALIGN_OPTIONS, message: "%{value} is not a valid text_align", allow_blank: true }
  validates :block_type, inclusion: { in: BLOCK_TYPES + SYSTEM_BLOCK_TYPES, message: "%{value} is not a valid block type" }
  validates :location, inclusion: { in: REGIONS + [''], message: "%{value} is not a valid location" }

  validate :block_validation
  validate :sub_block_validation

  before_validation :adjust_block_params

  def block_validation
    if CONTENT_REGIONS.include?(self.block_type) && ['container'].include?(self.location)
      self.errors[:block_type] << " invalid block type and location combo"
    end
  end

  def sub_block_validation
    if self.block_type == 'sub_block' && !self.block.present?
      self.errors[:block] << "Block is required"
    end
  end

  def as_json(options={})
    super(options.merge({:methods => [:page_ids]}))
  end

  def parent_block_options(current_page=nil)
    container_blocks = self.website.blocks.where(block_type: 'container')
    if current_page.present?
      block_options = container_blocks.includes(:pages).where(pages: {id: current_page.id})
    end
    if !block_options.present?
      block_options = container_blocks
    end
  end

  def blocks_splice_calc
    if self.blocks.count % 3 == 0
      splice_calc = 3
    elsif self.blocks.count % 4 == 0
      splice_calc = 4
    elsif self.blocks.count % 5 == 0 && self.blocks.count % 10 != 0
      splice_calc = 3
    elsif self.blocks.count % 5 == 0 && self.blocks.count % 10 == 0
      splice_calc = 4
    elsif self.blocks.count % 7 == 0
      splice_calc = 4
    elsif self.blocks.count % 2 == 0
      splice_calc = 2
    elsif self.blocks.count % 1 == 0
      splice_calc = 1
    else
      splice_calc = 0
    end
    return splice_calc
  end

  def blocks_push_calc(splice)
    return 0 if self.blocks.count == splice
    return 4 if self.blocks.count == 1 && splice == 3
    return 2 if self.blocks.count == 2 && splice == 3
    return 4 if self.blocks.count == 1 && splice == 4
    return 3 if self.blocks.count == 2 && splice == 4
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
