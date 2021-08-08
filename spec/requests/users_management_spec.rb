require 'rails_helper'
require_relative '../support/devise'

RSpec.describe "Users management", type: :request do

  context "from login admin user" do
    login_admin
    
    describe 'GET users#index' do
      
      let(:users) { FactoryBot.create_list(:user, 3) }

      it 'should render a successful response' do
        get users_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
        # assert_template 'posts/index'
        expect(assigns(:users)).to eq(User.all)
      end

    end
  end

end