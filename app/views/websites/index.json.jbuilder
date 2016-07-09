json.array!(@websites) do |website|
  json.extract! website, :id, :account_id, :name, :about, :domain_url, :google_analytics, :facebook, :twitter, :tags
  json.url website_url(website, format: :json)
end
