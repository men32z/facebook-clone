# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Post feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x[:bio] = 'born in some year in some place'
    has_x
  end

  scenario ' Form for post in the profile is complete' do
    user = User.create(user_valid)
    sign_in(user)
    visit user_path(user)
    expect(page).to have_content 'Create post'
    assert_selector "input[type='submit']"
    assert_selector "input[value='Create post']"
    assert_selector "textarea[name='Post[content]']"
  end

  scenario ' Form for post in the timeline is complete' do
    user = User.create(user_valid)
    sign_in(user)
    visit root_path
    expect(page).to have_content 'Create post'
    assert_selector "input[type='submit']"
    assert_selector "input[value='Create post']"
    assert_selector "textarea[name='Post[content]']"
  end

  scenario 'A created post should display author in timeline' do
    user = User.create(user_valid)
    sign_in(user)
    visit root_path
    example_post = 'Example text'
    fill_in 'post_content', with: example_post
    click_button 'Create post'
    expect(page).to have_content example_post
    expect(page).to have_content user.name
  end

  scenario 'A created post should display author in profile' do
    user = User.create(user_valid)
    sign_in(user)
    visit  user_path(user)
    example_post = 'Example text'
    fill_in 'post_content', with: example_post
    click_button 'Create post'
    expect(page).to have_content example_post
    expect(page).to have_content user.name
  end

  scenario 'post should display likes and comments'
end
