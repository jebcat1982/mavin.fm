Discovery::Application.routes.draw do
  get "listen/index"
  get "tags/autocomplete" => "tags#autocomplete", :as => :tags_autocomplete

  get 'music/new' => "music#new", :as => :new_music
  post 'music' => "music#create", :as => :music

  post "ratings" => "ratings#rate", :as => :ratings
  post "likes" => "listen#likes", :as => :likes
  post "dislikes" => "listen#dislikes", :as => :dislikes

  get "user/:username" => "user#show"
  get "user/:username/liked" => "user#liked"
  get "user/:username/disliked" => "user#disliked"

  resources :bands, :albums, :tags, :tracks
  resources :playlists do
    resources :playlist_tracks, :shallow => true
  end
  devise_for :users, :controllers => { :registrations => "registrations",
                                       :sessions => "sessions" 
                                     }

  root :to => "listen#index"
end
