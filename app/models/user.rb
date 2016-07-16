class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :websites, through: :accounts

  after_create :setup_account

  private

  def setup_account
    if !self.accounts.present?
      AccountUser.create(account: Account.new, user_id: self.id, role: 'Owner')
    end
  end

end
