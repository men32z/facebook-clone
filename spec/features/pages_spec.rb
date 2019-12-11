# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  scenario 'Should show home when user is not loged in'

  scenario 'Should show to post index when loged in '
end