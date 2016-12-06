class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    # can [:manage], :all do |item|
    #   user.email=='dsmithco@gmail.com'
    # end

    can [:read], [Page, Website, Category] do |item|
      true
    end

    can [:read, :index], [Form] do |item|
      (item.website.present?) && (can? :edit, Website.find(item.website.id))
    end

    can [:index, :manage], Website do |website|
      user.account_users.where(account_id: website.account_id, role: ['Owner','Admin','Editor']).present?
    end

    can [:index, :update, :edit], Website do |website|
      user.account_users.where(account_id: website.account_id, role: ['Owner','Admin','Editor']).present?
    end

    can [:create], [Category, Page, Form, Answer, AnswerQuestionOption] do |item|
      (item.website.present?) && (can? :edit, Website.find(item.website.id))
    end

    can [:create, :sort], [Block] do |item|
      (item.website.present?) && (can? :edit, Website.find(item.website.id)) && !Block::SYSTEM_BLOCK_TYPES.include?(item.block_type)
    end

    can [:edit, :update], [Category, Block, Page, Form, Answer, AnswerQuestionOption] do |item|
      (item.website.present?) && (can? :edit, Website.find(item.website.id))
    end

    can [:destroy], [Category, Form, Answer, AnswerQuestionOption] do |item|
      (item.website.present?) && (can? :edit, Website.find(item.website.id))
    end

    can [:destroy, :delete], [Block] do |block|
      (block.website.present?) &&
      (can? :edit, Website.find(block.website.id)) &&
      !Block::SYSTEM_BLOCK_TYPES.include?(block.block_type) &&
      block.blocks.blank?
    end

    can [:destroy], [Page] do |item|
      (can? :edit, item) && !item.is_homepage.present?
    end

    can [:create,:manage], [FormResponse] do |item|
      (item.form_id.present?) && (can? :edit, item.form)
    end

    can [:new], [Category, Block, Page, Form] do |item|
      user.account_ids.present?
    end

    can [:new], [Website] do |website|
      user.account_ids.present?
    end

    can [:create], [Website] do |website|
      user.account_users.where(account_id: website.account_id, role: ['Owner','Admin']).present?
    end

    can [:new, :create], [FormResponse, Answer, AnswerQuestionOption] do |item|
      true # TODO: add specifications for closed or unpublished forms
    end

    can [:manage], [Attachment, Image, HeroImage, Logo] do |h|
      can? :edit, h.attachable
    end

    can [:index, :manage], User do |u|
      common_account_ids = user.account_ids & u.account_ids
      common_account_users = u.account_users.where(role: ['Owner','Admin'], account_id: common_account_ids)
      user.id == u.id || common_account_users.any?
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
