require 'spec_helper'

describe ArticlesController, :type => :controller do

  describe 'GET #show' do
    before :each do
      @article = create(:published_article)
    end

    it 'returns http success' do
      get :show, { id: @article.to_param }
      expect(response).to be_success
    end

    it 'assigns an article to @article' do
      get :show, { id: @article.to_param }
      expect(assigns(:article)).to eq(@article)
    end

    it 'renders :show template' do
      get :show, { id: @article.to_param }
      expect(response).to render_template(:show)
    end
  end
end
