require 'spec_helper'

describe HomeController do

  context 'does not has a user in database' do
    describe 'GET #index' do
      it 'redirect to sign up page' do
        get :index
        expect(response).to redirect_to(sign_up_url)
      end
    end

    describe 'GET #about' do
      it 'redirect to sign up page' do
        get :about
        expect(response).to redirect_to(sign_up_url)
      end
    end
  end

  context 'already has a user in database' do
    before :each do
      create(:user)
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to be_success
      end

      it 'populates an array of published articles' do
        article1 = create(:published_article)
        article2 = create(:published_article)
        get :index
        expect(assigns(:articles)).to match_array([article2, article1])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #about' do
      it 'returns http success' do
        get :about
        expect(response).to be_success
      end

      it 'renders the :about view' do
        get :about
        expect(response).to render_template :about
      end
    end
  end
end
