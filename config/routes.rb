Rails.application.routes.draw do
  root 'pages#index', as: :root
  get 'dashboard/:id' => 'pages#dashboard', as: :dashboard
  post 'dashboard/:id' => 'pages#create', as: :posts
  post 'follow/:id' => 'pages#follow', as: :follow
  delete 'unfollow/:id' => 'pages#unfollow', as: :unfollow
  get '/:id/profile' => 'pages#profile', as: :user

  get 'sign-in' => 'session#new', as: :sign_in
  post 'sign-in' => 'session#create', as: :auth
  delete 'sign-out' => 'session#delete', as: :sign_out

  get 'sign-up' => 'user#new', as: :sign_up
  post 'sign-up' => 'user#create', as: :users

  get '/:id/profile/edit' => 'user#edit', as: :edit_user
  patch '/:id/profile' => 'user#update'

end
