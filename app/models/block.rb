class Block < ApplicationRecord
  belongs_to :website, optional: true
  acts_as_list scope: [:website_id, :location]

  default_scope { order('blocks.position ASC') }

  has_many :page_blocks
  has_many :pages, through: :page_blocks
  has_one :image, as: :attachable

  BLOCK_TYPES = ['custom', 'navigation', 'banner']
  REGIONS = ['top', 'bottom', 'main', 'main_top', 'main_bottom', 'main_left', 'main_right', 'end']

  validates :block_type, inclusion: { in: BLOCK_TYPES, message: "%{value} is not a valid block type" }
  validates :location, inclusion: { in: REGIONS, message: "%{value} is not a valid location" }

  def as_json(options={})
    super(options.merge({:methods => [:page_ids]}))
  end

end
