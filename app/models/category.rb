class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, :scope => :website_id, use: [:slugged, :scoped, :history]

  belongs_to :category
  belongs_to :website
  has_many :blocks
  has_many :categories
  has_many :page_categories
  has_many :pages, through: :page_categories

  validates :website, presence: true

  attr_accessor :continue_edit

  validates :name, uniqueness: { scope: :website_id, message: "must be unique" }

  def can_destroy
    !self.pages.present?
  end


end
