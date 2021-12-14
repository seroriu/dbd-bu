Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users/registrations' }
  get "/", to: "homes#index",as:"home"
  get "/mypage",to: "users#mypage"
  post "/posts/", to: "post#create"
  post "/posts/:id", to: "post#create_res"
  post "/faves/:id", to: "users#post_fave", as: "fave_post"
  get "/posts/new", to: "post#new", as: "new_post"
  get "/users/all", to: "users#all", as: "all"
  get "/posts/all", to: "post#all", as: "all_posts"
  get "/posts/:id", to: "post#show", as: "post_detail"
  delete "/posts/:id", to: "post#destroy",as: "post_destroy"
  delete "/re/:id", to: "post#destroy_res",as: "re_destroy"
  delete "/comment/:id", to: "users#destroy_comment",as: "comment_destroy"
  delete "/faves/:id", to: "users#destroy_fave",as: "fave_destroy"
  get "/users/:id", to: "users#show", as: "detail"
  post "/users/:id", to: "users#post_comment"
  delete "/users/delete/:id", to: "users#destroy",as: "user_delete"
  
end
