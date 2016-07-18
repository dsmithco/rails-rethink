json.extract! @attachment, :id, :asset, :created_at, :updated_at
json.asset_file_name @attachment.asset_file_name
json.thumb @attachment.asset(:thumb)
