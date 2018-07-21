Rails.application.routes.draw do
  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    root to: "home#index", as: 'homepage'
  end  
  get "/*path" => "application#change_path", constraints: { path: /(?!(#{I18n.available_locales.join("|")})\/).*/ }
  root to: "application#change_path"
end
