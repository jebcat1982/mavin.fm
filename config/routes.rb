Discovery::Application.routes.draw do
  get "listen/index"
  resources :bands, :albums, :tags, :tracks, :playlists, :playlist_tracks
  devise_for :users

  root :to => "listen#index"
end
