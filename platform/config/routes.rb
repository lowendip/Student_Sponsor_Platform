Rails.application.routes.draw do
  resources :sessions
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  
  namespace :sponsor do
    resources :projects
    get "projects/new", to: "projects#new", as: "projects_new"
    get "projects/:id", to: "projects#show", as: "projects_show"
    post "projects/update", to: "projects#update", as: "projects_update"
    post "projects/create", to: "projects#create", as: "projects_create"
    #get "projects", to: "projects#index", as: "projects"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#index"
end
