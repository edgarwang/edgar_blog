require 'spec_helper'

describe SessionsController do

  describe 'GET #new (sign in page)' do
    it 'returns http success' do
      get :new
      expect(response).to be_success
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid user sign in information' do
      before :each do
        @user = create(:user)
      end

      it 'redirect to articles page' do
        post :create, email: @user.email, password: 'secret'
        expect(response).to redirect_to(articles_url)
      end

      it 'add user inforamtion to the session' do
        post :create, email: @user.email, password: 'secret'
        expect(session[:user_id]).to eq(@user.id)
      end
    end

    context 'with invalid user sign in information' do
      before :each do
        @user = create(:user)
      end

      it 're-render :new page' do
        post :create, email: @user.email, password: 'invalidsecret'
        expect(response).to render_template :new
      end

      it 'does not set user information in session' do
        post :create, email: @user.email, password: 'invalidsecret'
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = create(:user)
      set_user_session(@user)
    end

    it 'clear user inforamtion in session' do
      expect(session[:user_id]).to eq(@user.id)
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirect to home#index page' do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
end
