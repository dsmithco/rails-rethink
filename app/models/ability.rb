class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    can [:manage], :all do |item|
      user.email=='dsmithco@gmail.com'
    end

    can [:read], :all do |item|
      true
    end

    can [:index, :manage], Website do |website|
      user.account_users.where(account_id: website.account_id, role: ['Owner','Admin']).present?
    end

    can [:index, :edit], Website do |website|
      user.account_users.where(account_id: website.account_id).present?
    end

    can [:manage], [Attachment, Image, HeroImage, Logo, Icon] do |h|
      can? :edit, h.attachable
    end

    can [:index, :manage], [Category, Block, Page] do |item|
      can? :edit, item.website
    end

    can [:new], [Category, Block] do |item|
      user.account_ids.present?
    end

    can [:index, :manage], User do |u|
      common_account_ids = user.account_ids & u.account_ids
      common_account_users = u.account_users.where(role: ['Owner','Admin'], account_id: common_account_ids)
      user.id == u.id || common_account_users
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
