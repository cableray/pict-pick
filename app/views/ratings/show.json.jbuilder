json.extract! @vote, :value, :rating_id

json.image_id @rating.image.id
json.average_rating @rating.mean
json.rating_count @rating.votes.count
