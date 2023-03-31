Rails.application.routes.draw do
    
  get 'admin/users' => "admin/users#index"
  patch "admin/users/:id" => "admin/users#update",as: "update_user"
  get 'admin' => "admin/homes#top"
  
  get "search_keyword" => "public/posts#search_keyword"
  
  resources :post do
    namespace :public do
      resource :favorites,only: [:create,:destroy]
    end
  end
  
  get "favorites/:user_id" => "public/favorites#index",as: "user_favorites"

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
  
  get 'users/:id' => "public/users#index",as: "mypage"
  get 'users/:id/show' => "public/users#show",as: "mypage_show"
  get 'users/:id/edit' => "public/users#edit",as: "mypage_edit"
  patch "users/:id" => "public/users#update",as: "mypage_update"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
