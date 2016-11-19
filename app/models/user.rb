class User < ApplicationRecord

  attr_accessor :website_name, :website_domain, :assign_account_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :websites, through: :accounts

  validates :name, presence: true
  validate :registration_validation, on: :create

  after_create :setup_account

  private

  def registration_validation
    unless self.assign_account_id.present?
      # self.errors[:website_domain] << 'is required' unless self.website_domain.present?
      self.errors[:website_name] << 'is required' unless self.website_name.present?
    end
  end

  def setup_account
    if self.assign_account_id.present?
      assign_account = Account.find(self.assign_account_id)
      self.accounts << assign_account
    elsif !self.account_ids.present?
      account_user = AccountUser.create(account: Account.new, user_id: self.id, role: 'Owner')
      if website_name.present?
        website = account_user.account.websites.create(name: website_name, theme: 'basic')
      end
    end
  end

end
