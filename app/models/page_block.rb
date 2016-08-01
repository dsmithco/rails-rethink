class PageBlock < ApplicationRecord
  belongs_to :block
  belongs_to :page
  acts_as_list scope: :page
  default_scope { order('page_blocks.position ASC') }
end
