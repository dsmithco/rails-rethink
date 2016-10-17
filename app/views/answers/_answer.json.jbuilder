json.extract! answer, :id, :answer_text, :form_response_id, :question_id, :question_json, :created_at, :updated_at
json.url answer_url(answer, format: :json)