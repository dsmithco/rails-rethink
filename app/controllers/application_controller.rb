class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_website

  def set_website
    @website = Website.where("domain_url like ?", "%#{request.host}%").first
    ApplicationController.layout "themes/#{@website.theme}"
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
