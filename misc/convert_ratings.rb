puts "Loading rails environment..."
require './config/environment.rb'

likes = Like.all
dislikes = Dislike.all

likes.each do |like|
  Rating.create(user_id: like.user_id, track_id: like.track_id, session_id: like.session_id, liked: true)
end

dislikes.each do |dislike|
  if dislike.user_id
    rating = Rating.where(user_id: dislike.user_id, track_id: dislike.track_id).first
  else
    rating = Rating.where(session_id: dislike.session_id, track_id: dislike.track_id).first
  end
  
  Rating.create(user_id: dislike.user_id, track_id: dislike.track_id, session_id: dislike.session_id, liked: false) if rating.nil?
end
