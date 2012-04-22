class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :session_id

  has_many :playlists
  has_many :likes
  has_many :dislikes
  has_many :tracks, :through => :likes
  has_many :tracks, :through => :dislikes
  
  after_create :assign_all_to_user

  def assign_all_to_user
    playlists = Playlist.where(session_id: session_id)
    playlists.each do |playlist|
      playlist.user_id = id
      playlist.save
    end

    dislikes = Dislike.where(session_id: session_id)
    dislikes.each do |dislike|
      dislike.user_id = id
      dislike.save
    end

    likes = Like.where(session_id: session_id)
    likes.each do |like|
      like.user_id = id
      like.save
    end
  end
end
