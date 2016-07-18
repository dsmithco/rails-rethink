class Account < ApplicationRecord
  has_many :account_users
  has_many :users, through: :account_users
  has_many :websites

  before_create :randomize_id

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Account.where(id: self.id).exists?
  end

end
