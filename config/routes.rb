Rails.application.routes.draw do
  
  root to: "public/homes#top"
  
  devise_for :users,skip: [:passwords], controllers: {
    registraitons: "public/registrations",
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
