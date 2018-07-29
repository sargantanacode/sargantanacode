Rails.application.routes.draw do
  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :posts, only: [:show]
    root to: "home#index", as: "homepage"

    namespace :admin do
      resources :posts do
        put :publish, as: "publish"
        put :draft, as: "draft"
      end
    end
  end  
  get "/*path" => "application#change_path", constraints: { path: /(?!(#{I18n.available_locales.join("|")})\/).*/ }
  root to: "application#change_path"
end
