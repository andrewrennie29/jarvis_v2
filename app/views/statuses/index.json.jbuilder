json.array!(@statuses) do |status|
  json.extract! status, :id, :notstarted, :inprogress, :forreview, :delayed, :complete, :todo_id
  json.url status_url(status, format: :json)
end
