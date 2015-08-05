json.array!(@recurs) do |recur|
  json.extract! recur, :id, :recurs, :{, :false}, :frequency, :daypattern, :enddate, :latestdate, :nextdate, :todo_id
  json.url recur_url(recur, format: :json)
end
