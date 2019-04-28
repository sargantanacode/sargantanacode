require 'rails_helper'

RSpec.describe User, type: :model do
  let(:admin) { create(:user, :admin) }
  let(:user) { build(:user) }

  it 'has a valid user factory' do
    expect(user).to be_valid
  end

  it 'has a valid admin factory' do
    expect(admin).to be_valid
    expect(admin.admin?).to be true
  end

  it 'is not valid without an e-mail' do
    user_without_email = build(:user, email: nil)
    expect(user_without_email).not_to be_valid
  end

  it 'has a unique e-mail' do
    user_with_existing_email = build(:user, email: admin.email)
    expect(user_with_existing_email).not_to be_valid
  end

  it 'is not valid with an invalid e-mail' do
    user_with_invalid_email = build(:user, email: 'abc')
    expect(user_with_invalid_email).not_to be_valid
  end

  it 'is not valid without a password' do
    user_without_password = build(:user, password: nil)
    expect(user_without_password).not_to be_valid
  end

  it 'is not valid with a too short password' do
    user_with_short_password = build(:user, password: '12345')
    expect(user_with_short_password).not_to be_valid
  end

  it 'is not valid without a name' do
    user_without_name = build(:user, name: nil)
    expect(user_without_name).not_to be_valid
  end

  it 'can use custom fields with devise' do
    bio = 'This is a sample bio'
    user_with_bio = build(:user, bio: bio)
    expect(user_with_bio.bio).to eq(bio)
  end

  it 'can get translated enums' do
    expect(admin.translated_role).to eq('Administrador')
  end
end
