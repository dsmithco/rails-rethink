json.extract! @image, :id, :asset, :position, :created_at, :updated_at
json.asset_file_name @image.asset_file_name
json.thumb @image.asset(:thumb)
json.medium @image.asset(:medium)
json.link @image.asset(:large)
json.large @image.asset(:large)
