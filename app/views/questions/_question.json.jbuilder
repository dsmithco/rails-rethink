json.extract! question, :id, :name, :about, :help, :question_type, :is_required, :conditional_id, :conditional_value, :conditional_condition, :position, :deleted_at, :created_at, :updated_at
json.url question_url(question, format: :json)