Rails.application.routes.draw do
  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { registrations: "users/registrations"}
    get "post/:id" => "posts#show", as: "post"
    get "page/:id" => "pages#show", as: "page"
    post "post/:id/comments" => "posts#comment", as: "comments"
    get "new-admin" => "pages#admin", as: "admin"
    post "new-admin/new" => "pages#create_admin", as: "admin_new"
    get "categories" => "categories#index", as: "categories"
    get "category/:id" => "categories#show", as: "category"
    get "courses" => "courses#index", as: "courses"
    get "course/:id" => "courses#show", as: "course"
    get "profile/:id" => "pages#profile", as: "profile"
    get "contact" => "pages#contact", as: "contact"
    post "contact/new" => "pages#create_contact", as: "contact_new"
    get "search" => "pages#search", as: "search"
    get "team" => "pages#team", as: "team"
    get "rss" => "posts#rss", format: "atom", as: "rss"
    get "about-us" => "pages#about_us", as: "about_us"
    root to: "posts#index", as: "homepage"

    # Redirecting old links for the new ones
    get "article/:slug" => redirect("post/%{slug}")

    namespace :admin do
      resources :posts, except: [:show] do
        put :publish, as: "publish"
        put :draft, as: "draft"
        put :destroy_image, as: "destroy_image"
      end
      resources :pages, except: [:show] do
        put :publish, as: "publish"
        put :draft, as: "draft"
      end
      resources :users, except: [:new, :create]
      resources :categories, except: [:show]
      resources :courses, except: [:show]
      resources :images
      resources :comments, except: [:new, :show, :create] do
        put :approve, as: "approve"
        put :pend, as: "pend"
      end
      root to: "dashboard#index", as: "dashboard"
    end
  end
  get "/*path" => "application#change_path", constraints: { path: /(?!(#{I18n.available_locales.join("|")})\/).*/ }
  root to: "application#change_path"
end
