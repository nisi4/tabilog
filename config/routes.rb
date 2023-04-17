Rails.application.routes.draw do
    
  get 'admin/users' => "admin/users#index"
  patch "admin/users/:id" => "admin/users#update",as: "update_user"
  get 'admin' => "admin/homes#top"
  
  get "search_keyword" => "public/posts#search_keyword"

  namespace :public do
    resources :posts do
      resources :comments,only: [:index,:create,:destroy]
    end
  end
  
  post "public/posts/:post_id/favorites" => "public/favorites#create",as: "favorite"
  delete "public/posts/:post_id/favorites" => "public/favorites#destroy",as: "unfavorite"
  get "user/:user_id/public/favorites" => "public/favorites#index",as: "user_favorites"
  
  post "public/users/:user_id/relationships" => "public/relationships#create",as: "follow"
  delete "public/users/:user_id/relationships" => "public/relationships#destroy",as: "unfollow"
  get "public/users/:user_id/followings" => "public/relationships#followings",as: "following"
  get "public/users/:user_id/followers" => "public/relationships#followers",as: "follower"

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
  patch "users/release/:id" => "public/users#release",as: "mypage_release"
  patch "users/nonrelease/:id" => "public/users#nonrelease",as: "mypage_nonrelease"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
