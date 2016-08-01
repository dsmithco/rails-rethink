class Block < ApplicationRecord
  belongs_to :website
  has_many :page_blocks
  has_many :pages, through: :page_blocks
  
  BLOCK_TYPES = ['custom', 'navigation', 'banner']
  REGIONS = ['top', 'bottom', 'main', 'main_top', 'main_bottom', 'main_left', 'main_right', 'end']

  validates :block_type, inclusion: { in: BLOCK_TYPES, message: "%{value} is not a valid block type" }
  validates :location, inclusion: { in: REGIONS, message: "%{value} is not a valid location" }

end
