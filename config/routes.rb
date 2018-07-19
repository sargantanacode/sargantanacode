Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: "home#index", as: 'homepage'
    devise_for :users
  end
end
