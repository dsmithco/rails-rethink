class User < ApplicationRecord

  attr_accessor :website_name, :website_domain

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :websites, through: :accounts

  after_create :setup_account

  validates :name, presence: true
  validates :website_domain, presence: true, on: :create
  validates :website_name, presence: true, on: :create

  private

  def setup_account
    if !self.accounts.present?
      account_user = AccountUser.create(account: Account.new, user_id: self.id, role: 'Owner')
      if website_domain.present?
        website = account_user.account.websites.create(name: website_name, domain_url: website_domain, theme: 'basic')
      end
    end
  end

end
