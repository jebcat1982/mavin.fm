Discovery::Application.routes.draw do
  get "listen/index"
  get "tags/autocomplete" => "tags#autocomplete", :as => :tags_autocomplete

  get 'music/new' => "music#new", :as => :new_music
  post 'music' => "music#create", :as => :music

  resources :bands, :albums, :tags, :tracks
  resources :playlists do
    resources :playlist_tracks, :shallow => true
  end
  devise_for :users

  root :to => "listen#index"
end
