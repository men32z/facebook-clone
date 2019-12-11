# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  it 'is valid with with valid attributes' do
    new_user = User.new(valid_user)
    expect(new_user).to be_valid
  end

  it 'is not valid without email' do
    new_user = User.new(valid_user)
    new_user.email = nil
    expect(new_user).to_not be_valid
  end

  it 'is not valid without name' do
    new_user = User.new(valid_user)
    new_user.name = nil
    expect(new_user).to_not be_valid
  end

  it 'is not valid without password' do
    new_user = User.new(valid_user)
    new_user.password = nil
    expect(new_user).to_not be_valid
  end

  it 'was downcased before save' do
    new_user = User.new(valid_user)
    new_user.email = 'MIkeGuas25@Gmail.cOm'
    new_user.save
    expect(new_user.email).to eq(new_user.email.downcase)
  end

  it 'is not valid when email regex is not valid' do
    new_user = User.new(valid_user)
    new_user.email = 'emailnovalido.com'
    expect(new_user).to_not be_valid
    new_user.email = 'emailnovalido@'
    expect(new_user).to_not be_valid
  end

  it 'is not valid with email length > 255' do
    new_user = User.new(valid_user)
    new_user.email = ('a' * 246) + '@gmail.com'
    expect(new_user).to_not be_valid
  end

  it 'is not valid with name length betwen 2 and  50' do
    new_user = User.new(valid_user)
    new_user.name = 'a'
    expect(new_user).to_not be_valid
    new_user.name = 'a' * 51
    expect(new_user).to_not be_valid
  end

  it 'is not valid when email is duplicated' do
    User.create(valid_user)
    new_user = User.new(valid_user)
    expect(new_user).to_not be_valid
  end

  it 'is not valid when password length is < than 6' do
    new_user = User.new(valid_user)
    new_user.password = '12345'
    expect(new_user).to_not be_valid
  end

end
