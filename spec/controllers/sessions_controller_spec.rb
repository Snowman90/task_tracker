# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'logs user in' do
      user = User.create!(email: 'user@example.org', password: 'very-secret')
      post :create, params: { session: { email: 'user@example.org', password: 'very-secret' } }

      expect(response).to have_http_status(:redirect)
      expect(session[:current_user_id]).to eq(user.id)
    end
    it 'logs user out' do
      u = User.create!(email: 'aldo1@hodor.pl', password: 'password')
      session[:current_user_id] = u.id
      delete :destroy
      expect(response).to have_http_status(:redirect)
      expect(session[:current_user_id]).to be_nil
    end
  end
end
