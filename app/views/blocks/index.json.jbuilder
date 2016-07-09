json.array!(@blocks) do |block|
  json.extract! block, :id, :name, :about, :website_id, :block_type, :position, :location
  json.url block_url(block, format: :json)
end
