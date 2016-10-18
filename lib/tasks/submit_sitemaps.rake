require 'rest-client'

desc "Submit sitemaps to search engines"
task :submit_sitemaps => :environment do
  sent_sitmaps = []
  Website.where.not(domain_url:[nil,'']).each do |website|
    begin
      website.submit_sitemaps
      sent_sitmaps = "#{website.domain_url}"
    rescue
      Rails.logger.info "Unable to send sitemap for #{website.domain_url}"
      puts "Unable to send sitemap for #{website.domain_url}"
    end
  end

end
