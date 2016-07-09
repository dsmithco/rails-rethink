class Website < ApplicationRecord
  belongs_to :account
  has_many :pages
end
