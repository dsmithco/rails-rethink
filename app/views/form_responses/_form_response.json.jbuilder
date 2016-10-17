json.extract! form_response, :id, :form_id, :created_at, :updated_at
json.url form_response_url(form_response, format: :json)