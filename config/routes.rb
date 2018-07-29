Rails.application.routes.draw do
  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :posts, only: [:show]
    root to: "posts#index", as: "homepage"

    namespace :admin do
      resources :posts, except: [:show] do
        put :publish, as: "publish"
        put :draft, as: "draft"
      end
    end
  end  
  get "/*path" => "application#change_path", constraints: { path: /(?!(#{I18n.available_locales.join("|")})\/).*/ }
  root to: "application#change_path"
end
