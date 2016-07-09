json.array!(@pages) do |page|
  json.extract! page, :id, :name, :about, :website_id, :position, :page_id
  json.url page_url(page, format: :json)
end
