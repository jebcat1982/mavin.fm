Discovery::Application.routes.draw do
  get "music/show"

  get "music/new"

  get "music/create"

  get "listen/index"
  resources :bands, :albums, :tags, :tracks
  resources :playlists do
    resources :playlist_tracks, :shallow => true
  end
  devise_for :users

  root :to => "listen#index"
end
