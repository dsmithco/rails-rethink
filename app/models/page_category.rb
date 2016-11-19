class PageCategory < ApplicationRecord
  belongs_to :page, touch: true
  belongs_to :category, touch: true
end
