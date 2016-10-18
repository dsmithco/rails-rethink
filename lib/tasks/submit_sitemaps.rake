require 'rest-client'

desc "Submit sitemaps to search engines"
task :submit_sitemaps => :environment do
  Website.where.not(domain_url:[nil,'']).each do |website|
    begin
      url_res =  RestClient.get("https://#{website.domain_url}", headers={})
      if url_res.headers[:host_provider] == "Rethink Web Design"
        response = RestClient.get("http://www.google.com/webmasters/sitemaps/ping?sitemap=https://#{website.domain_url}/sitemap.xml", headers={})
        if response.code == 200
          Rails.logger.info "Successfully sent sitemap for #{website.domain_url}"
          puts "Successfully sent sitemap for #{website.domain_url}"        end
      end
    rescue
      Rails.logger.info "Unable to send sitemap for #{website.domain_url}"
      puts "Unable to send sitemap for #{website.domain_url}"
    end
  end
end
