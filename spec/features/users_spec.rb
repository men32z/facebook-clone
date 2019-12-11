# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  scenario 'correct log in form is correct' do
    visit new_user_session_path
    expect(page).to have_content 'Log in'
    assert_selector "input[name='user[email]']"
    assert_selector "input[type='submit']"
  end

  scenario 'User Sign in form is correct' do
    visit new_user_registration_path
    expect(page).to have_content 'Sign up'
    assert_selector "input[ name= 'user[name]' ]"
    assert_selector "input[ name= 'user[email]' ]"
    assert_selector "input[ name= 'user[password]' ]"
    assert_selector "input[ name= 'user[password_confirmation]' ]"
  end

  scenario 'User correctly logs in' do
    user = user.create(user_valid)
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'
  end
end
