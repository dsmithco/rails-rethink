json.extract! form, :id, :name, :about, :description, :open_at, :close_at, :is_published, :website_id, :created_at, :updated_at
json.url form_url(form, format: :json)