require 'pry-byebug'
require 'rails_helper'
require_relative '../support/devise'

RSpec.describe "Users management", type: :request do

  context "from login admin user" do
    login_admin
    
    describe 'GET users#index' do

      it 'should render a successful response' do
        create_list(:user, 3)
        get users_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:users)).to eq(User.all)
        expect(response).to render_template(:index)
      end

    end

    describe 'GET users#new' do
      it 'should render a successful response' do
        get new_user_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:user)).to be_a(User)
        expect(response).to render_template(:new)
      end
    end

    describe 'POST users#create' do
      context 'with valid parameters' do
        let(:valid_attributes) { attributes_for(:user) }

        it 'creates a new User' do
          expect do
            post users_url, params: { user: valid_attributes }
          end.to change(User, :count).by(1)
        end
  
        it 'redirects to the users list' do
          post users_url, params: { user: valid_attributes }
          expect(response).to redirect_to(users_url)
          follow_redirect!
          expect(response).to render_template(:index)
          expect(response.body).to include("Le compte a été créé.")
        end
      end
  
      context 'with invalid parameters' do
        let(:user) { create(:user) }
        let(:users_count) { User.count }
        let(:invalid_attributes) { attributes_for(:user).merge!(email: 'test@111', msisdn: '1') }
        
        it 'does not create a new User' do
          post users_url, params: { user: invalid_attributes }
          expect(User.count).to eq(users_count) # User count unchanged
        end
  
        it "renders new User template" do
          post users_url, params: { user: invalid_attributes }
          expect(response).to render_template(:new)
        end
      end

    end

    describe 'GET users#show' do
      let(:user) { create(:user) }

      it 'should render a successful response' do
        get user_path(user)
        expect(response).to have_http_status(:ok)
        expect(assigns(:user)).to eq(user)
        expect(response).to render_template(:show)
      end
    end

    describe 'PUT users#update' do
      context 'with valid parameters' do
        let(:user) { create(:user) } 
        let(:new_attributes) { attributes_for(:user).merge(id: user.id) }

        it 'updates the requested user' do
          expect do
            put user_url(user), params: { user: new_attributes }
            user.reload
          end.to change(user, :updated_at)
        end
  
        it 'redirects to the user' do
          put user_url(user), params: { user: new_attributes }
          expect(response).to redirect_to(user_url(user))
          follow_redirect!
          expect(response).to render_template(:show)
          expect(response.body).to include("Le compte a été modifié.")
        end
      end

    end

  end

end