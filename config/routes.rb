Discovery::Application.routes.draw do
  get "listen/index"
  get "tags/autocomplete" => "tags#autocomplete", :as => :tags_autocomplete

  resources :bands, :albums, :tags, :tracks, :music
  resources :playlists do
    resources :playlist_tracks, :shallow => true
  end
  devise_for :users

  root :to => "listen#index"
end
