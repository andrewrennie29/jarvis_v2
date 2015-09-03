json.array!(@followups) do |followup|
  json.extract! followup, :id
  json.url followup_url(followup, format: :json)
end
