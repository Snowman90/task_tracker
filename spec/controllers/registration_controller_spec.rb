# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      { user:
        { email: 'aldo@hodor.pl',
          password: 'YayPassword',
          password_confirmation: 'YayPassword' } }
    end

    let(:invalid_params) do
      { user:
        { email: 'aldo@hodor.pl',
          password: 'YayPassword',
          password_confirmation: 'noope' } }
    end

    it 'creates user profile' do
      expect do
        expect do
          post :create, params: valid_params
        end.to change(User, :count).by(1)
      end.to change(ActionMailer::Base.deliveries, :count).by(1)

      user = User.last
      expect(user.active).to be_falsey
      expect(session[:current_user_id]).to be_nil
      expect(response).to have_http_status(:redirect)

      delivered_email = ActionMailer::Base.deliveries.last
      assert_includes delivered_email.to, user.email
    end

    it 'checks password confirmation' do
      expect do
        post :create, params: invalid_params
      end.not_to change(User, :count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #activate' do
    let(:user) { User.create(email: 'a@a.pl', password: 'asdasd123', activation_token: SecureRandom.uuid) }

    it 'returns http success' do
      expect(user).to be_persisted

      get :activate, params: { activation_token: user.activation_token }

      user.reload

      expect(user.active).to be_truthy
      expect(response).to have_http_status(:redirect)
    end
  end
end
