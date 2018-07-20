Rails.application.routes.draw do
  root to: "home#index", as: 'homepage'
  devise_for :users
  post "change_lang/:locale" => "application#change_lang", :as => "change_lang"
  
  scope "(:locale)" do
    get "/*path" => "application#change_lang"
  end
end
