require 'rails_helper'

describe "Devise", type: :feature do
  it "allows users to log in" do
    create(:user, email: 'user@example.com', password: 'password')
    user = User.last
    user.confirm
    visit new_user_session_path(locale: I18n.locale)
    within("#new_user") do
      fill_in 'Correo electrónico', with: 'user@example.com'
      fill_in 'Contraseña', with: 'password'
    end
    click_button 'Iniciar sesión'
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  it "allows users to sign up" do
    visit new_user_registration_path(locale: I18n.locale)
    within("#new_user") do
      fill_in 'Correo electrónico', with: 'user@example.com'
      fill_in 'Contraseña', with: 'password'
      fill_in 'Confirmar contraseña', with: 'password'
      fill_in 'Nombre', with: 'Name'
    end
    click_button 'Registrarse'
    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end
end
