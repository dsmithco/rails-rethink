class RegistrationsController < Devise::RegistrationsController

  def after_update_path_for(resource)
    case resource
    when :user, User
      user_path(resource)
    else
      super
    end
  end

end
