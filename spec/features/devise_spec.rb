require 'rails_helper'

describe "Devise", type: :feature do
  it "allows users to log in" do
    create(:user, email: 'user@example.com', password: 'password')
    user = User.last
    user.confirm
    visit new_user_session_path(locale: I18n.locale)
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log In'
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
  end

  it "allows users to sign up" do
    visit new_user_registration_path(locale: I18n.locale)
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      fill_in 'Name', with: 'Name'
    end
    click_button 'Sign Up'
    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end
end
