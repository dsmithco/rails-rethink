class AccountUser < ApplicationRecord
  belongs_to :account
  belongs_to :user

  ACCOUNT_USER_ROLES = ['Owner','Admin','Editor']

  validates :role, inclusion: { in: ACCOUNT_USER_ROLES, message: "%{value} is not a valid role" }

  before_validation :assign_role

  private

  def assign_role
    self.role ||= 'Editor'
  end

end
