json.array!(@product_variants) do |product_variant|
  json.extract! product_variant, :id, :product_id, :size_id, :quantity
  json.url product_variant_url(product_variant, format: :json)
end
