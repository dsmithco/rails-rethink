class Block < ApplicationRecord
  belongs_to :form
  delegate :account, to: :website
  acts_as_list scope: [:page_id, :block_id]

  default_scope { order('blocks.position ASC') }

  belongs_to :page, touch: true

  has_many :page_blocks
  has_many :pages, through: :page_blocks

  has_one :image, as: :attachable
  has_many :hero_images, -> { order(position: :asc) }, as: :attachable
  has_many :blocks
  belongs_to :block, touch: true
  belongs_to :category

  # has_one :formable, as: :formable
  # has_one :form, through: :formable

  TEXT_ALIGN_OPTIONS = ['left','right','center','justify']
  SYSTEM_BLOCK_TYPES = ['navigation','page_content']
  TOP_LEVEL_BLOCKS = ['category_list', 'container', 'custom', 'form', 'hero_images']
  LOWER_LEVEL_BLOCKS = ['sub_block']
  BLOCK_TYPES = TOP_LEVEL_BLOCKS + LOWER_LEVEL_BLOCKS + SYSTEM_BLOCK_TYPES
  ROWS = {
    '4':{
      name: '3 | 3 | 3 | 3',
      config: [3,3,3,3]
    },
    '3':{
      name: '4 | 4 | 4',
      config: [4,4,4]
    },
    '2':{
      name: '6 | 6',
      config: [6,6]
    },
    '84':{
      name: '8 | 4',
      config: [8,4]
    },
    '48':{
      name: '4 | 8',
      config: [4,8]
    },
    '363':{
      name: '3 | 6 | 3',
      config: [3,6,3]
    },
    '1':{
      name: '12',
      config: [12]
    }
  }

  attr_accessor :continue_edit, :display_page_name

  validates :text_align, inclusion: { in: TEXT_ALIGN_OPTIONS, message: "%{value} is not a valid text_align", allow_blank: true }
  validates :block_type, inclusion: { in: BLOCK_TYPES, message: "%{value} is not a valid block type" }

  validate :sub_block_validation

  validate :page_content_validation

  before_create :default_values

  before_destroy :check_content_block

  after_update :update_page_content

  def column_config
    if self.columns.present?
      ROWS[self.columns.to_s.to_sym][:config]
    end
  end

  def sub_block_validation
    if self.block_type == 'sub_block' && !self.block.present?
      self.errors[:block] << "Block is required"
    end
  end

  def website
    if self.page.present?
      return self.page.website
    elsif self.block.present?
      return self.block.website
    end
  end

  def as_json(options={})
    super(options.merge({:methods => :page_id}))
  end

  def parent_block_options(current_page=nil)
    container_blocks = self.website.blocks.where(block_type: 'container')
    if current_page.present?
      block_options = container_blocks.includes(:page).where(pages: {id: current_page.id})
    end
    if !block_options.present?
      block_options = container_blocks
    end
    return container_blocks
  end

  def blocks_splice_calc
    if self.blocks.count <= self.columns
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
    else
      splice_calc = self.columns
    end
    return splice_calc
  end

  def display_page_name
    self.page.display_name
  end

  def display_page_name=(bool)
    self.page.update_columns(display_name: bool)
    self[:updated_at] = Time.zone.now
  end

  def blocks_push_calc(splice)
    return 0 if self.blocks.count == splice
    return 4 if self.blocks.count == 1 && splice == 3
    return 2 if self.blocks.count == 2 && splice == 3
    return 4 if self.blocks.count == 1 && splice == 4
    return 3 if self.blocks.count == 2 && splice == 4
  end

  def is_empty
    # self.bg_color.blank? &&
    # self.image.blank? &&
    # self.blocks.blank? &&
    # self.form.blank? &&
    # self.category.blank? &&
    # self.about.blank? &&
    # (self.name.blank? || (self.block_type == 'page_content' && self.display_page_name.blank?)) &&
    # self.hero_images.blank?
  end

  def next_position
    if self.block.present?
      return self.block.blocks.last.position + 1
    else
      return self.page.blocks.last.position + 1
    end
  end

  private

  def default_values
    if self.page_id.blank? && self.block.present?
      self.page_id = self.block.page_id
    end
    self.position ||= self.next_position
  end

  def check_content_block
    if SYSTEM_BLOCK_TYPES.include? self.block_type
      self.errors[:block_type] << " cannot delete #{self.block_type}"
    end
  end

  def update_page_content
    if self.block_type == 'page_content' && (self.about_changed? || self.name_changed? || self.page.display_name_changed?)
      self.page.update_columns(name: self.name, about: self.about, updated_at: Time.zone.now)
    end
  end

  def page_content_validation
    if self.block_type == 'page_content'
      if self.name.blank?
        self.errors[:name] << " cannot be blank"
      end
    end
  end
end
