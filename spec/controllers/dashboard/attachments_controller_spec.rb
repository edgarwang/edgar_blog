require 'spec_helper'

describe Dashboard::AttachmentsController, :type => :controller do
  let(:user) { create(:user) }

  context 'user has already signed in' do
    before :each do
      set_user_session(user)
    end

    describe 'GET #new' do
      it 'returns http success' do
        get :new
        expect(response).to be_success
      end

      it 'assigns a new attachment to @attachment' do
        get :new
        expect(assigns(:attachment)).to be_a_new(Attachment)
      end

      it 'renders :new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      it 'redirect to attachment index page' do
        post :create, attachment: attributes_for(:attachment)
        expect(response).to redirect_to(dashboard_attachments_url)
      end

      it 'add one more attachment to database' do
        expect {
          post :create, attachment: attributes_for(:attachment)
        }.to change(Attachment, :count).by(1)
      end

      it 'assigns a newly created attachment as @attachment' do
        post :create, attachment: attributes_for(:attachment)
        expect(assigns(:attachment)).to be_a(Attachment)
        expect(assigns(:attachment)).to be_persisted
      end
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to be_success
      end

      it 'assigns all attachment to @attachments' do
        attachment = create(:attachment)
        get :index
        expect(assigns(:attachments)).to match_array([attachment])
      end

      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #destroy' do
      before :each do
        @attachment = create(:attachment)
      end

      it 'redirect to attachment index page' do
        delete 'destroy', id: @attachment.to_param
        expect(response).to redirect_to(dashboard_attachments_url)
      end

      it 'delete an attachment from database' do
        expect {
          delete 'destroy', id: @attachment.to_param
        }.to change(Attachment, :count).by(-1)
      end
    end
  end
end
