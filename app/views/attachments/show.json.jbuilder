json.extract! @resource, :id, :asset, :position, :created_at, :updated_at
json.asset_file_name @resource.asset_file_name
json.thumb @resource.asset(:thumb)
json.medium @resource.asset(:medium)
