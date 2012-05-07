class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :session_id
  attr_accessor :session_id

  has_many :playlists
  has_many :ratings
  has_many :liked_tracks,     :through => :ratings,  :source => :track, :conditions => ['liked = ?',  true]
  has_many :disliked_tracks,  :through => :ratings,  :source => :track, :conditions => ['liked = ?', false]
  
  after_create :assign_to_user

  validates :username, :presence => true,
                       :format => { :with => /^[a-zA-Z0-9]+$/ }

  def assign_to_user
    playlists = Playlist.where(session_id: session_id)
    playlists.each do |playlist|
      playlist.user_id = id
      playlist.session_id = nil
      playlist.save
    end

    dislikes = Dislike.where(session_id: session_id)
    dislikes.each do |dislike|
      dislike.user_id = id
      dislike.session_id = nil
      dislike.save
    end

    likes = Like.where(session_id: session_id)
    likes.each do |like|
      like.user_id = id
      like.session_id = nil
      like.save
    end
  end
end
