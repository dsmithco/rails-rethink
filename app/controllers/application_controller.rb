class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_website
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :set_csrf_cookie_for_ng
  before_action :set_provider_header

	def set_csrf_cookie_for_ng
	  cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
	end

  def set_current_website
    @browser_request = request
    get_current_website
    render_website
  end

  def get_current_website
    # if @current_website.present?
    # end
    if @browser_request.domain == Rails.application.config.host_domain
      find_rethink_website
    else
      @current_website ||= find_website(@browser_request.host)
      if @current_website.present? && @current_website.domain_url.present? && @browser_request.host != @current_website.domain_url
        redirect_to :status => 301, :host => @current_website.domain_url
      end
    end
  end

  def set_site_meta
    @site_title = "#{@current_website.name}" if @current_website.name.present?
    @site_title = "#{@site_title} - #{@current_website.subtitle}" if @current_website.subtitle.present?
    @site_description = "#{@current_website.description}" if @current_website.description.present?
  end

  def find_website(req_host)
    website = Website.where("domain_url = ? OR domain_url = ? OR domain_url = ?",
                                     "#{req_host}", "www.#{req_host}",
                                     "#{req_host.gsub('www.','')}").first
    return website
  end

  def find_rethink_website
    if ['','www'].include? @browser_request.subdomain
      @current_website = Website.where(domain_url: Rails.application.config.host_domain).first
    else
      subdomain_array = @browser_request.subdomain.split('-')
      account_id = subdomain_array[0]
      website_id = subdomain_array[1]
      @current_website = Website.where(account_id: account_id, id: website_id).first
    end
  end

  def render_website
    set_site_meta
    if !@current_website.present?
      redirect_to "#{Rails.application.config.host_domain}:#{request.port}"
    else
      ApplicationController.layout "themes/#{@current_website.theme}/layout"
    end
  end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # force_ssl if: :ssl_configured?
  #
  # def ssl_configured?
  #   !Rails.env.development?
  # end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :website_name, :website_domain])
    end

    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end

    def set_provider_header
      response.headers['host_provider'] = 'Rethink Web Design'
    end

end
