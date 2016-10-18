class Website < ApplicationRecord
  belongs_to :account
  has_many :pages
  has_many :blocks
  has_many :categories
  has_one :logo, as: :attachable
  has_one :icon, as: :attachable
  has_many :hero_images, -> { order(position: :asc) }, as: :attachable
  has_many :images, as: :attachable

  has_many :forms

  validate :domain_url_uniqueness
  validates :account, presence: true
  after_initialize :set_default_styles
  after_create :setup_nginx_prod
  after_save :submit_sitemaps

  def set_default_styles
    self.style['brand-primary'] = '#009bff' unless self.style['brand-primary'].present?
    self.style['brand-info'] = '#5bc0de' unless self.style['brand-info'].present?
    self.style['brand-success'] = '#00cc66' unless self.style['brand-success'].present?
    self.style['brand-warning'] = '#ff9933' unless self.style['brand-warning'].present?
    self.style['brand-danger'] = '#ff3300' unless self.style['brand-danger'].present?
    self.style['navbar-height'] = '60px' unless self.style['navbar-height'].present?
    self.style['headings-font-family'] = FONT_FAMILY_OPTIONS[0] unless self.style['headings-font-family'].present?
    self.style['font-family-sans-serif'] = FONT_FAMILY_OPTIONS[0] unless self.style['font-family-sans-serif'].present?
    self.theme = 'basic' unless self.theme.present?
  end

  FONT_FAMILY_OPTIONS = [
    '"Lato", "Helvetica Neue", Helvetica, Arial', # Default font family
    '"Helvetica Neue", sans-serif, Helvetica, Arial',
    'Impact, Haettenschweiler, "Arial Black", "sans serif"',
    '"Courier New", Courier, monospace',
    '"Palatino Linotype", "Book Antiqua", Palatino, serif'
  ]

  def style_settings
    output = ""
    self.style.each do |k,v|
      output = "#{output}$#{k}:#{v};\n" if v.present?
    end
    return output
  end

  def self.theme_options
    options = []
    Dir.glob("**/layouts/themes/*").each do |theme|
      theme_dirs = theme.split('/')
      theme_opt = theme_dirs[theme_dirs.length - 1]
      options << theme_opt
    end
    return options
  end

  validates :theme, inclusion: { in: Website.theme_options, message: "%{value} is not a valid theme" }

  after_save :push_changes

  attr_accessor :testing

  def push_changes
    puts "\n\n\n\n\n#{self.changes.to_json}\n\n\n\n\n"
  end

  def testing
    testing_will_change!
    "#{self.name.snakecase}_#{self.id.to_s}"
  end

  def rethink_url
    return "#{self.account_id}-#{self.id}.#{Rails.application.config.host_domain}"
  end

  def rethink_href
    return "//#{self.rethink_url}"
  end

  def submit_sitemaps
      begin
        url_res =  RestClient.get("https://#{self.domain_url}", headers={})
        if url_res.headers[:host_provider] == "Rethink Web Design"
          google_response = RestClient.get("http://www.google.com/webmasters/sitemaps/ping?sitemap=https://#{self.domain_url}/sitemap.xml", headers={})
          bing_response = RestClient.get("http://www.bing.com/webmaster/ping.aspx?siteMap=https://#{self.domain_url}/sitemap.xml", headers={})
          if google_response.code == 200 && bing_response.code == 200
            Rails.logger.info "Successfully sent sitemap for #{self.domain_url}"
            ActionMailer::Base.mail(:from => "info@rethinkwebdesign.com",
                                    :to => "info@rethinkwebdesign.com",
                                    :subject => "Sitemaps Sent",
                                    :body => "Sitemaps for #{self.domain_url} sent.").deliver
          end
        end
      rescue
        Rails.logger.info "Unable to send sitemap for #{self.domain_url}"
      end
  end

  handle_asynchronously :submit_sitemaps

  private

  def domain_url_uniqueness
    if self.domain_url.present?
      check_website = Website.where('domain_url = ? OR domain_url = ? OR domain_url = ?',
                                     "#{self.domain_url}",
                                     "www.#{self.domain_url}",
                                     "#{self.domain_url.gsub('www.','')}").first
      if check_website.present? && check_website != self
        self.errors[:domain_url] << "#{self.domain_url} is already in use."
      end
    end
  end

  def setup_nginx_prod
    if Rails.env == 'production'
      system("cd /etc/nginx/sites-enabled && echo '#{ENV['DEPLOY_PW']}' | sudo -S cp website_template website_#{self.account_id}-#{self.id}")
      system("cd /etc/nginx/sites-enabled && echo '#{ENV['DEPLOY_PW']}' | sudo -S sed -i 's/#//g' website_#{self.account_id}-#{self.id}")
      system("cd /etc/nginx/sites-enabled && echo '#{ENV['DEPLOY_PW']}' | sudo -S sed -i 's/SUB_DOMAIN/#{self.account_id}-#{self.id}/g' website_#{self.account_id}-#{self.id}")
      if self.domain_url.present?
        no_www_domain_url = self.domain_url.gsub('www.','')
        system("cd /etc/nginx/sites-enabled && echo '#{ENV['DEPLOY_PW']}' | sudo -S sed -i 's/SERVER_NAME_1/#{no_www_domain_url}/g' website_#{self.account_id}-#{self.id}")
        if no_www_domain_url.split('.').count == 2
          system("cd /etc/nginx/sites-enabled && echo '#{ENV['DEPLOY_PW']}' | sudo -S sed -i 's/SERVER_NAME_2/www.#{no_www_domain_url}/g' website_#{self.account_id}-#{self.id}")
        else
          system("cd /etc/nginx/sites-enabled && echo '#{ENV['DEPLOY_PW']}' | sudo -S sed -i 's/server_name SERVER_NAME_2;//g' website_#{self.account_id}-#{self.id}")
        end
      end
      system("echo '#{ENV['DEPLOY_PW']}' | sudo -S /home/deploy/certbot-auto certonly --webroot -w /home/deploy/rethinkwebdesign/current/public -d #{self.account_id}-#{self.id}.rethinkwebdesign.com --email dsmithco@gmail.com --agree-tos --expand")
      system("echo '#{ENV['DEPLOY_PW']}' | sudo -S service nginx reload")
    end
  end

end
