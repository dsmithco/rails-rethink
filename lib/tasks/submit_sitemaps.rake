require 'rest-client'

desc "Submit sitemaps to search engines"
task :submit_sitemaps => :environment do
  sent_sitmaps = []
  Website.where.not(domain_url:[nil,'']).each do |website|
    begin
      url_res =  RestClient.get("https://#{website.domain_url}", headers={})
      if url_res.headers[:host_provider] == "Rethink Web Design"
        response = RestClient.get("http://www.google.com/webmasters/sitemaps/ping?sitemap=https://#{website.domain_url}/sitemap.xml", headers={})
        if response.code == 200
          sent_sitmaps << "#{website.domain_url}"
          Rails.logger.info "Successfully sent sitemap for #{website.domain_url}"
          puts "Successfully sent sitemap for #{website.domain_url}"        end
      end
    rescue
      Rails.logger.info "Unable to send sitemap for #{website.domain_url}"
      puts "Unable to send sitemap for #{website.domain_url}"
    end
  end
  ActionMailer::Base.mail(:from => "info@rethinkwebdesign.com",
                          :to => "info@rethinkwebdesign.com",
                          :subject => "Sitemaps Sent",
                          :body => "Sitemaps for #{sent_sitmaps.join(', ')} sent.").deliver

end
