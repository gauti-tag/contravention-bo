require 'rails_helper'
require_relative '../support/devise'

RSpec.describe "Profiles management", type: :request do

  context "from login admin user" do
    login_admin
    
    describe 'GET admin_profiles#index' do

      it 'should render a successful response' do
        create_list(:admin_profile, 3)
        get admin_profiles_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:profiles)).to eq(AdminProfile.order(title: :asc))
        expect(response).to render_template(:index)
      end

    end

    describe 'GET admin_profiles#new' do
      it 'should render a successful response' do
        create_list(:admin_ability, 10)
        get new_admin_profile_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:profile)).to be_a(AdminProfile)
        expect(assigns(:abilities)).to eq(AdminAbility.order(title: :asc))
        expect(response).to render_template(:new)
      end
    end

    describe 'POST admin_profiles#create' do
      context 'with valid parameters' do
        let(:valid_attributes) { attributes_for(:admin_profile) }
        let(:abilities) { create_list(:admin_ability, 10).pluck(:id) }

        it 'creates a new Profile' do
          expect do
            post admin_profiles_url, params: { admin_profile: valid_attributes.merge(admin_ability_ids: abilities) }
          end.to change(AdminProfile, :count).by(1)
        end
  
        it 'redirects to the profiles list' do
          post admin_profiles_url, params: { admin_profile: valid_attributes.merge(admin_ability_ids: abilities) }
          expect(response).to redirect_to(admin_profiles_url)
          follow_redirect!
          expect(response).to render_template(:index)
          expect(response.body).to include("Le profil a été créé.")
        end
      end

    end

    describe 'GET admin_profiles#show' do
      let(:profile) { profile_with_abilities }

      it 'should render a successful response' do
        get admin_profile_path(profile)
        expect(response).to have_http_status(:ok)
        expect(assigns(:profile)).to eq(profile)
        expect(response).to render_template(:show)
      end
    end

  end

end