json.array!(@attachments) do |attachment|
  json.extract! attachment, :id
  json.thumb attachment.asset(:thumb)
  json.asset_file_name attachment.asset_file_name
  json.url attachment_url(attachment, format: :json)
end
