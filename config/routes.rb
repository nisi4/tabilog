Rails.application.routes.draw do
    
  get "search_keyword" => "public/posts#search_keyword"
  get "search_name" => "public/posts#search_name"
  
  get 'posts/new' => "public/posts#new"
  post "posts" => "public/posts#create"
  get 'posts' => "public/posts#index"
  get 'posts/:id/edit' => "public/posts#edit",as: "edit_post"
  patch "posts/:id" => "public/posts#update",as: "update_post"
  delete "posts/:id" => "public/posts#destroy",as: "destroy_post"
    
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
