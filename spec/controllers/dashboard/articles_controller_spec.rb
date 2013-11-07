require 'spec_helper'

describe Dashboard::ArticlesController do

  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'user dose not sign in' do
      it 'redirect to home#index page' do
        get :index
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user already sign in' do
      before :each do
        set_user_session(user)
        @trash_article = create(:trash_article)
        @draft_article = create(:draft_article)
        @published_article = create(:published_article)
      end

      context 'without query params' do
        it 'returns http success' do
          get :index
          expect(response).to be_success
        end

        it 'assigns all articles except trash as @articles' do
          get :index
          expect(assigns(:articles)).to match_array([@published_article, @draft_article])
        end

        it 'render :index template' do
          get :index
          expect(response).to render_template :index
        end
      end

      context 'with query params' do
        describe 'status=published' do
          it 'returns http success' do
            get :index, status: 'published'
            expect(response).to be_success
          end

          it 'assigns all articles except trash as @articles' do
            get :index, status: 'published'
            expect(assigns(:articles)).to match_array([@published_article])
          end

          it 'render :index template' do
            get :index, status: 'published'
            expect(response).to render_template :index
          end
        end

        describe 'status=draft' do
          it 'returns http success' do
            get :index, status: 'draft'
            expect(response).to be_success
          end

          it 'assigns all articles except trash as @articles' do
            get :index, status: 'draft'
            expect(assigns(:articles)).to match_array([@draft_article])
          end

          it 'render :index template' do
            get :index, status: 'draft'
            expect(response).to render_template :index
          end
        end
      end
    end
  end

  describe 'GET #trash' do
    context 'user does not signed in' do
      it 'redrect to home#index page' do
        get :trash
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already signed in' do
      before :each do
        set_user_session(user)
      end

      it 'returns http success' do
        get :trash
        expect(response).to be_success
      end

      it 'assigns the requested trashed articles as @articles' do
        create(:draft_article)
        @trash = create(:trash_article)
        get :trash
        expect(assigns(:articles)).to match_array([@trash])
      end

      it 'renders :trash template' do
        get :trash
        expect(response).to render_template :trash
      end
    end
  end

  describe 'GET #show' do
    context 'user does not signed in' do
      before :each do
        @article = create(:published_article)
      end

      it 'redrect to home#index page' do
        get :show, { id: @article.to_param }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already signed in' do
      before :each do
        @article = create(:published_article)
        set_user_session(user)
      end

      it 'returns http success' do
        get :show, { id: @article.to_param }
        expect(response).to be_success
      end

      it 'assigns the requested published article as @article' do
        get :show, { id: @article.to_param }
        expect(assigns(:article)).to eq(@article)
      end

      it 'works with draft article too' do
        draft = create(:draft_article)
        get :show, { id: draft.to_param }
        expect(response).to be_success
      end

      it 'renders :show template' do
        get :show, { id: @article.to_param }
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    context 'user does not sign in' do
      it 'redirect to home#index page' do
        get :new
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already sign in' do
      before :each do
        set_user_session(user)
      end

      it 'returns http success' do
        get :new
        expect(response).to be_success
      end

      it 'assigns a new article as @article' do
        get :new
        expect(assigns(:article)).to be_a_new(Article)
      end

      it 'renders :new template' do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    before :each do
      @article = create(:draft_article)
    end

    context 'user does not sign in' do
      it 'redirect to home#index page' do
        get :edit, { id: @article.to_param }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already sign in' do
      before :each do
        set_user_session(user)
      end

      it 'returns http success' do
        get :edit, { id: @article.to_param }
        expect(response).to be_success
      end

      it 'assigns the requested article as @article' do
        get :edit, { id: @article.to_param }
        expect(assigns(:article)).to eq(@article)
      end

      it 'renders :edit template' do
        get :edit, { id: @article.to_param }
        expect(response).to render_template :edit
      end

      it 'refuse to edit trashed article' do
        trashed_article = create(:trash_article)
        get :edit, { id: trashed_article.to_param }
        expect(response).to redirect_to(dashboard_articles_url)
      end
    end
  end

  describe 'POST #create' do
    context 'user does not sign in' do
      it 'redirect to home#index page' do
        post :create, { article: attributes_for(:draft_article) }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already sign in' do
      before :each do
        set_user_session(user)
      end

      context 'with valid params' do
        before :each do
          @valid_attributes = attributes_for(:draft_article)
        end

        it 'creates a new Article' do
          expect {
            post :create, { article: @valid_attributes }
          }.to change(Article, :count).by(1)
        end

        it 'assigns a newly created article as @article' do
          post :create, { article: @valid_attributes }
          expect(assigns(:article)).to be_a(Article)
          expect(assigns(:article)).to be_persisted
        end

        it 'redirects to index page' do
          post :create, { article: @valid_attributes }
          expect(response).to redirect_to(dashboard_articles_url)
        end
      end

      context 'with invalid params' do
        before :each do
          @invalid_attibutes = attributes_for(:draft_article, title: nil)
        end
        it 'assigns a newly created but unsaved article as @article' do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, { article: @invalid_attibutes }
          expect(assigns(:article)).to be_a_new(Article)
        end

        it 're-renders the :new template' do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          post :create, { article: @invalid_attibutes}
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @article = create(:draft_article)
      @valid_update_attributes = { 'title' => 'New Title' }
      @invalid_update_attributes = { 'slug' => 'AAAAA-BDE?' }
    end

    context 'user does not sign in' do
      it 'redirect to home#index page' do
        put :update, { id: @article.to_param, article: @valid_update_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already signed in' do
      before :each do
        set_user_session(user)
      end

      describe 'with valid params' do
        it 'updates the requested article' do
          Article.any_instance.should_receive(:update).with(@valid_update_attributes)
          put :update, { id: @article.to_param, article: @valid_update_attributes }
        end

        it 'assigns the requested article as @article' do
          put :update, { id: @article.to_param, article: @valid_update_attributes }
          expect(assigns(:article)).to eq(@article)
        end

        it 'redirects to the index page' do
          put :update, { id: @article.to_param, article: @valid_update_attributes }
          expect(response).to redirect_to(dashboard_articles_url)
        end
      end

      describe 'with invalid params' do
        it 'assigns the article as @article' do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          put :update, { id: @article.to_param, article: @invalid_update_attributes }
          expect(assigns(:article)).to eq(@article)
        end

        it 're-renders the :edit template' do
          # Trigger the behavior that occurs when invalid params are submitted
          Article.any_instance.stub(:save).and_return(false)
          put :update, { id: @article.to_param, article: @invalid_update_attributes }
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'POST #send_to_trash' do
    before :each do
      @article = create(:draft_article)
    end

    context 'user does not signed in' do
      it 'rediect to home#index page' do
        post :send_to_trash, { id: @article.to_param }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already signed in' do
      before :each do
        set_user_session(user)
      end

      it 'returns http success' do
        post :send_to_trash, { id: @article.to_param }
        expect(response).to be_success
      end

      it 'assigns requested article as @article' do
        post :send_to_trash, { id: @article.to_param }
        expect(assigns(:article)).to eq(@article)
      end

      it 'requested article would be move to trash' do
        post :send_to_trash, { id: @article.to_param }
        @article.reload
        expect(@article.status).to eq('trash')
      end
    end
  end

  describe 'POST #send_to_trash' do
    before :each do
      @article = create(:trash_article)
    end

    context 'user does not signed in' do
      it 'rediect to home#index page' do
        post :restore, { id: @article.to_param }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'user has already signed in' do
      before :each do
        set_user_session(user)
      end

      it 'returns http success' do
        post :restore, { id: @article.to_param }
        expect(response).to be_success
      end

      it 'assigns requested article as @article' do
        post :restore, { id: @article.to_param }
        expect(assigns(:article)).to eq(@article)
      end

      it 'requested article would be restore' do
        post :restore, { id: @article.to_param }
        @article.reload
        expect(@article.status).to eq('draft')
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @article = create(:draft_article)
    end

    context 'user does not signed in' do
      it 'redirect to home#index page' do
        delete :destroy, { id: @article.to_param }
      end
    end

    context 'user has already signed in' do
      before :each do
        set_user_session(user)
      end

      it 'destroys the requested article' do
        expect {
          delete :destroy, { id: @article.to_param }
        }.to change(Article, :count).by(-1)
      end

      it 'redirects to the articles list' do
        delete :destroy, { id: @article.to_param }
        expect(response).to redirect_to(dashboard_articles_url)
      end
    end
  end

  describe 'DELETE #empty_trash' do
    context 'user does not signed in' do
      it 'redirect to home#index page' do
        delete :empty_trash
      end
    end

    context 'user has already signed in' do
      before :each do
        set_user_session(user)
        create(:trash_article)
        create(:trash_article)
      end

      it 'destroys all trashed articles' do
        expect {
          delete :empty_trash
        }.to change(Article, :count).by(-2)
      end

      it 'redirects to the trashed articles list' do
        delete :empty_trash
        expect(response).to redirect_to(trash_dashboard_articles_url)
      end
    end
  end
end
