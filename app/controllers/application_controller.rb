class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_website
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_current_website
    @current_website = Website.where("domain_url = ?", "#{request.host}").first || Website.first
    ApplicationController.layout "themes/#{@current_website.theme}"
    # "#{params[:controller]}Controller".classify.constantize.layout "themes/#{@current_website.theme}"
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name]
    end


end
