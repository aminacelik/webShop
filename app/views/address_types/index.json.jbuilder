json.array!(@address_types) do |address_type|
  json.extract! address_type, :id, :type
  json.url address_type_url(address_type, format: :json)
end
