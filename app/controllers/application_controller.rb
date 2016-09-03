class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_website
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :set_csrf_cookie_for_ng

	def set_csrf_cookie_for_ng
	  cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
	end

  def set_current_website
    @browser_request = request
    if request.domain == Rails.application.config.host_domain
      if ['','www'].include? request.subdomain
        @current_website = Website.where(domain_url: Rails.application.config.host_domain).first
      else
        subdomain_array = request.subdomain.split('-')
        account_id = subdomain_array[0]
        website_id = subdomain_array[1]
        @current_website = Website.where(account_id: account_id, id: website_id).first
      end
    else
      @current_website = Website.where("domain_url = ?", "#{request.host}").first
    end
    if !@current_website.present?
      redirect_to Rails.application.config.host_domain
    else
      ApplicationController.layout "themes/#{@current_website.theme}/layout"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :website_name, :website_domain])
    end

    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end

end
