# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'fetch tasks' do
      Task.create(subject: 'Oh hi!')

      get :index

      expect(assigns(:task)).to be_a_new(Task)
      expect(assigns(:tasks)).to match_array(Task.all)
    end
  end
end
