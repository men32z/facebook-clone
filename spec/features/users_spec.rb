# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x[:bio] = 'born in some year in some place'
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
    user = User.create(user_valid)
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'
    expect(page).to have_content user.name
    expect(page).to have_content 'Log Out'
  end

  scenario 'User fails log in' do
    user = User.create(user_valid)
    visit new_user_session_path

    fill_in 'user_email', with: user.email + 'a'
    fill_in 'user_password', with: user_valid[:password] + 'a'
    click_button 'Log in'
    expect(page).to_not have_content user.name
    expect(page).to_not have_content 'Log Out'
  end

  scenario 'User registers succesfully' do
    visit new_user_registration_path
    expect do
      fill_in 'user_name', with: user_valid[:name]
      fill_in 'user_email', with: user_valid[:email]
      fill_in 'user_password', with: user_valid[:password]
      fill_in 'user_password_confirmation', with: user_valid[:password_confirmation]
      click_button 'Sign up'
    end.to change(User, :count).by(1)
    user = User.last
    expect(user.name).to eq(user_valid[:name])
  end

  scenario 'User profile renders properly' do
    user = User.create(user_valid)
    sign_in user
    Post.create(user_id: user.id, content: 'Lorem Impsum')
    visit user_path(user)
    expect(page).to have_content user.name
    expect(page).to have_content user.bio
    expect(page).to have_content user.posts.last.content
    assert_selector "img[src = '#{user.photo}']"
  end

  scenario 'User edit form renders properly' do
    user = User.create(user_valid)
    sign_in user
    visit edit_user_path(user)
    assert_selector "input[name= 'user[name]']"
    assert_selector "textarea[name='user[bio]']"
    assert_selector "input[name='user[photo]']"
  end

  scenario 'User can edit their profile' do
    user = User.create(user_valid)
    sign_in user
    fake_user = {name:"Fake name", bio:"nice bio", photo:"/filename.jpg"}
    visit edit_user_path(user)
    fill_in "user_name", with: fake_user[:name]
    fill_in "user_bio", with: fake_user[:bio]
    fill_in "user_photo", with: fake_user[:photo]
    click_button "Update Profile"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content fake_user[:name]
    expect(page).to have_content fake_user[:bio]
    assert_selector "img[src='#{fake_user[:photo]}']"
  end
end
