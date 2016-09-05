class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    # can [:edit], [:all] do |a|
    #   o.account_id==user.account_id
    # end

    can [:manage], :all do |item|
      user.email=='dsmithco@gmail.com'
    end

    can [:read], :all do |item|
      true
    end

    # can [:index, :read, :update], Account do |account|
    #   user.account_ids.include? account.id || user.email=='dsmithco@gmail.com'
    # end
    #
    can [:index, :manage], Website do |website|
      user.account_ids.include? website.account_id
    end
    #
    # can [:create], Website do |website|
    #   user.account_ids.present? || user.email=='dsmithco@gmail.com'
    # end
    #
    can [:index, :manage], User do |u|
      # common_account_ids = user.account_ids & u.account_ids
      # common_account_users = u.account_users.where(account_id: common_account_ids)
      # user.id == u.id || common_account_ids
    end
    #
    can [:manage], Attachment do |h|
      true
    end
    #
    can [:index, :manage], Page do |page|
      if page.website.present?
        user.account_ids.include? page.website.account_id
      else
        user.account_ids.present?
      end
    end

    # if user.email == 'dsmithco@gmail.com'
    #   can :manage, :all
    # else
    #   can :read, :all
    # end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
