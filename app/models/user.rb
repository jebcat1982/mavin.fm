class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :session_id, :registered

  has_many :playlists
  has_many :ratings
  has_many :stations
  has_many :liked_tracks,     :through => :ratings,  :source => :track, :conditions => ['liked = ?',  true]
  has_many :disliked_tracks,  :through => :ratings,  :source => :track, :conditions => ['liked = ?', false]
  
  validates :username, :presence => true,
                       :format => { :with => /^[a-zA-Z0-9]+$/ }

end
