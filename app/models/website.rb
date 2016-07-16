class Website < ApplicationRecord
  belongs_to :account
  has_many :pages
  validates :domain_url, uniqueness: true, allow_blank: true
  validates :account, presence: true
end
