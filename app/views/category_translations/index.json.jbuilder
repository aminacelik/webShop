json.array!(@category_translations) do |category_translation|
  json.extract! category_translation, :id, :language_id, :category_id, :name
  json.url category_translation_url(category_translation, format: :json)
end
