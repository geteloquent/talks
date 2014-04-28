require 'spec_helper'

describe SessionsController do
  describe 'POST create' do
    context 'when it is a new user' do
      before { allow(controller).to receive(:info) { attributes_for(:user) } }

      it 'creates an user' do
        expect { post :create }.to change(User, :count)
      end

      it 'saves the user in the session' do
        post :create
        expect(session[:user_id]).to_not be_nil
      end
    end

    context 'when user already exists' do
      let!(:user) { create(:user) }
      before do
        allow(controller).to receive(:info) { attributes_for(:user, \
          github_uid: user.github_uid) }
      end

      it 'does not create a new user' do
        expect { post :create }.not_to change(User, :count)
      end

      it 'saves the user in the session' do
        post :create
        expect(session[:user_id]).to eq user.id
      end
    end
  end

  describe 'GET destroy' do
    it 'redirects to the root' do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
