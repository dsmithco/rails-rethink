class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json, :js

  def after_update_path_for(resource)
    case resource
    when :user, User
      user_path(resource)
    else
      super
    end
  end

  # POST /resource
  def create
    sign_up_params[:password_confirmation] = sign_up_params[:password]
    super
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

end
