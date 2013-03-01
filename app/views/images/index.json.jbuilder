json.array!(@images) do |image|
  json.extract! image, :title, :description, :image, :ratings
  json.url image_url(image, format: :json)
end