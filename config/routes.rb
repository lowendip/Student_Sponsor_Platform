Rails.application.routes.draw do
  get "sign_in", to: "sessions#new", as: "sign_in"
  get "sign_up", to: "users#new", as: "sign_up", constraints: { user: /^(sponsor|student)$/ }
  delete "sign_out", to: "sessions#delete", as: "sessions_delete"
  resources :sessions

  get "sponsor_projects", to: "sponsor_projects#index", as: "sponsor_projects"
  get "sponsor_projects/:id", to: "sponsor_projects#show", as: "sponsor_projects_show"
  get "student_projects", to: "student_projects#index", as: "student_projects"
  get "student_projects/:id", to: "student_projects#show", as: "student_projects_show"

  get "students", to: "students#index", as: "students"
  get "sponsors", to: "sponsors#index", as: "sponsors"


  post "users/create", to: "users#create", as: "users_create"
  resources :users do
    member do
      get :confirm_email
    end
  end

  namespace :sponsor do
    get "dashboard/new", to: "dashboard#new", as: "dashboard_new"
    get "dashboard/:id", to: "dashboard#show", as: "dashboard_show"
    get "dashboard", to: "dashboard#index", as: "dashboard"
    get "dashboard/:id/edit", to: "dashboard#edit", as: "dashboard_edit"
    patch "dashboard/:id/update", to: "dashboard#update", as: "dashboard_update"
    delete "dashboard/:id/delete", to: "dashboard#delete", as: "dashboard_delete"
    post "dashboard/create", to: "dashboard#create", as: "dashboard_create"
    post "dashboard/:id/hide", to: "dashboard#hide", as: "dashboard_hide"
    post "dashboard/:id/unhide", to: "dashboard#unhide", as: "dashboard_unhide"
    post "dashboard/:id/renew", to: "dashboard#renew", as: "dashboard_renew"
  end

  namespace :student do
    get "dashboard/new", to: "dashboard#new", as: "dashboard_new"
    get "dashboard/:id", to: "dashboard#show", as: "dashboard_show"
    get "dashboard", to: "dashboard#index", as: "dashboard"
    get "dashboard/:id/edit", to: "dashboard#edit", as: "dashboard_edit"
    patch "dashboard/:id/update", to: "dashboard#update", as: "dashboard_update"
    delete "dashboard/:id/delete", to: "dashboard#delete", as: "dashboard_delete"
    post "dashboard/create", to: "dashboard#create", as: "dashboard_create"
    post "dashboard/:id/hide", to: "dashboard#hide", as: "dashboard_hide"
    post "dashboard/:id/unhide", to: "dashboard#unhide", as: "dashboard_unhide"
    post "dashboard/:id/renew", to: "dashboard#renew", as: "dashboard_renew"
  end

   namespace :admin do
    get "dashboard/:id", to: "dashboard#show", as: "dashboard_show"
    get "dashboard", to: "dashboard#index", as: "dashboard"
    get "dashboard/:id/edit", to: "dashboard#edit", as: "dashboard_edit"
    patch "dashboard/:id/update", to: "dashboard#update", as: "dashboard_update"
    delete "dashboard/:id/delete", to: "dashboard#delete", as: "dashboard_delete"
    post "dashboard/:id/hide", to: "dashboard#hide", as: "dashboard_hide"
    post "dashboard/:id/unhide", to: "dashboard#unhide", as: "dashboard_unhide"
    post "dashboard/:id/renew", to: "dashboard#renew", as: "dashboard_renew"

    get "users", to: "users#index", as: "users"
    get "users/:id/edit", to: "users#edit", as: "users_edit"
    patch "users/:id/update", to: "users#update", as: "users_update"
    delete "users/:id/delete", to: "users#delete", as: "users_delete"
    post "users/:id/disable", to: "users#disable", as: "users_disable"
    post "users/:id/reactivate", to: "users#reactivate", as: "users_reactivate"

    get "domains", to: "domains#index", as: "domains"
    get "domains/:id/edit", to: "domains#edit", as: "domains_edit"
    patch "domains/:id/update", to: "domains#update", as: "domains_update"
    delete "domains/:id/delete", to: "domains#delete", as: "domains_delete"
    get "domains/new", to: "domains#new", as: "domains_new"
    post "domains/create", to: "domains#create", as: "domains_create"
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
