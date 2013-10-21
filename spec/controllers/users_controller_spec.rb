require 'spec_helper'

describe UsersController do

  describe 'GET #new (sign up page)' do
    it 'returns http success' do
      get :new
      expect(response).to be_success
    end

    it 'assigns a new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new user into the database' do
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it 'redirect to sign in page' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to(sign_in_url)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user into the database' do
        expect {
          post :create, user: attributes_for(:user, name: '')
        }.to_not change(User, :count)
      end

      it 're-render the :new template' do
        post :create, user: attributes_for(:user, name: '')
        expect(response).to render_template :new
      end
    end
  end
end
