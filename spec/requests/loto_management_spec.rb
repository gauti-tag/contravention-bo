require 'rails_helper'
require_relative '../support/devise'

RSpec.describe "Loto management", type: :request do

  context "from login admin user" do
    login_admin
    
    describe 'GET loto#placed_bets' do

      it 'should render a successful response' do
        get placed_bets_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:placed_bets)
      end

    end

    describe 'GET loto#winning_bets' do

      it 'should render a successful response' do
        get winning_bets_path
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:winning_bets)
      end

    end
  end

end