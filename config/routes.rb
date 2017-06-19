Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home', to: 'index#home'
  get '/about', to: 'index#about', as: 'about'
  get '/contact', to: 'index#contact', as: 'contact'
  get '/top-:category/:company', to: 'index#place', as: 'place'
  get '/top-:category', to: 'index#ranking', as: 'ranking'
  get '/search', to: 'index#search', as: 'search'
  get '/shareup/:id', to: 'index#share_up', as: 'shareup'
  get '/likeup/:id', to: 'index#like_up', as: 'likeup'

  scope 'admin' do
    resources :companies
    resources :categories do
      resources :sub_categories
    end
    resources :pronoun_orders, only: [:index,:show] do
      get :text_submission_callback
      get :order_review
    end
    resources :nav_links
  end

  root 'index#home'

  resources :admin, only: [:index,:create,:new]

end
