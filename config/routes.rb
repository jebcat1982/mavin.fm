Discovery::Application.routes.draw do
  get "listen/index"
  resources :bands, :albums, :tags, :tracks
  resources :playlists do
    resources :playlist_tracks, :shallow => true
  end
  devise_for :users

  root :to => "listen#index"
end
