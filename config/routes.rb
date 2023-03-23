Rails.application.routes.draw do
  
  get "search" => "public/posts#search_keyword"
  
  get 'posts/new' => "public/posts#new"
  post "posts" => "public/posts#create"
  get 'posts' => "public/posts#index"
  get 'posts/:id/edit' => "public/posts#edit"
  patch "posts/:id" => "public/posts#update"
    
  root to: "public/homes#top"
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#new_guest"
  end
  
  devise_for :admin,skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
