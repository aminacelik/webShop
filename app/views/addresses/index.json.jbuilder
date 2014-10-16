json.array!(@addresses) do |address|
  json.extract! address, :id, :street_name, :street_number, :floor, :flat, :default, :user_id, :address_type_id
  json.url address_url(address, format: :json)
end
