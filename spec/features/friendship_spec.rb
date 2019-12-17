# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Friendship feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:user_valid2) do
    has_x = { name: 'Randal', email: 'other2@email.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:user_valid3) do
    has_x = { name: 'Boo', email: 'other3@email.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:user_valid4) do
    has_x = { name: 'Sully', email: 'other4@email.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:friend_link_text) { 'Send friend request' }

  scenario 'send a friend request from the users list' do
    user = User.create(user_valid)
    sign_in user
    user2 = User.create(user_valid2)

    visit users_path
    expect(page).to have_content friend_link_text
    assert_selector "a[href='#{friendships_path}']"
    click_on friend_link_text
    assert_selector "div[class='pending'] a[href='#{user_path(user2)}']"
    click_on user2.name
    assert_selector "button[class='disabled']", text: 'request sent'
  end

  scenario 'send a friend request from the profile' do
    user = User.create(user_valid)
    sign_in user
    user2 = User.create(user_valid2)

    visit user_path(user2)
    expect(page).to have_content friend_link_text
    assert_selector "a[href='#{friendships_path}']"
    click_on friend_link_text
    assert_selector "div[class='pending'] a[href='#{user_path(user2)}']"
    click_on user2.name
    assert_selector "button[class='disabled']", text: 'request sent'
  end

  scenario 'show only friends posts on timeline' do
    user = User.create(user_valid)
    sign_in user

    user2 = User.create(user_valid2)
    # second is our friend
    Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: true)

    user3 = User.create(user_valid3)

    post1 = user.posts.create(content: 'this is a post')
    post2 = user2.posts.create(content: '2 this is a post 2')

    post3 = user3.posts.create(content: '3 this is a post 3')

    visit root_path

    expect(page).to have_content post1.content
    expect(page).to have_content post2.content

    expect(page).to_not have_content post3.content
  end
  scenario 'show friends, outgoing and incoming friend requests' do
    user = User.create(user_valid)
    sign_in user

    user2 = User.create(user_valid2)
    # second is our friend
    Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: true)

    user3 = User.create(user_valid3)
    # we send request to this one.
    Friendship.create(user_id: user.id, friend_id: user3.id)
    user4 = User.create(user_valid4)
    # this one sent request to us
    Friendship.create(user_id: user4.id, friend_id: user.id)

    visit friendships_path

    assert_selector "div[class='friends'] a[href='#{user_path(user2)}']"
    assert_selector "div[class='pending'] a[href='#{user_path(user3)}']"
    assert_selector "div[class='incoming'] a[href='#{user_path(user4)}']"
  end
  scenario 'confirm requests and delete friend' do
    user1 = User.create(user_valid)
    sign_in user1
    user2 = User.create(user_valid2)

    # send request from user1 to user2
    visit user_path(user2)
    click_on friend_link_text
    sign_out user1

    # accept the request
    sign_in user2
    visit friendships_path
    click_on 'Accept'
    assert_selector "div[class='friends'] a[href='#{user_path(user1)}']"
    # now its our friend and we are going to delete him

    click_on 'Delete'
    expect(page).to_not have_content user1.name
  end
end
