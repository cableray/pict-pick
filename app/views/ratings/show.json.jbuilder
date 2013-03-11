json.extract! @rating, :value, :image_id

json.average_rating @image.rating
json.rating_count @image.ratings.count
