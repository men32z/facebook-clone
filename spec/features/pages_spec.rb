# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  scenario 'Should show home when user is not loged in' do
    visit root_path
    expect(page).to have_content 'This is a microverse project'
    assert_selector "a[href='#{new_user_session_path}']"
  end

  scenario 'Should show timeline when loged in ' do
    user = User.create(user_valid)
    sign_in user
    visit root_path
    expect(page).to have_content 'Timeline'
  end
end
