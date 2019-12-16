# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'get#index' do
    it 'Should show index' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
