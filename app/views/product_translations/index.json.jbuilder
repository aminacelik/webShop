json.array!(@product_translations) do |product_translation|
  json.extract! product_translation, :id, :language_id, :product_id, :title, :description, :price
  json.url product_translation_url(product_translation, format: :json)
end
