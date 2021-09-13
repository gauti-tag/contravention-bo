require 'rails_helper'
require_relative '../support/devise'

RSpec.describe "Games management", type: :request do

  context "from login admin user" do
    login_admin
    
    describe 'GET games#index' do

      it 'should render a successful response' do
        create_list(:game, 5)
        get games_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:games)).to eq(Game.all)
        expect(response).to render_template(:index)
      end

    end

    describe 'GET games#new' do
      it 'should render a successful response' do
        get new_game_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:game)).to be_a(Game)
        expect(response).to render_template(:new)
      end
    end

    describe 'POST games#create' do
      context 'with valid parameters' do
        let(:valid_attributes) { attributes_for(:game) }

        it 'creates a new Game' do
          expect do
            post games_url, params: { game: valid_attributes }
          end.to change(Game, :count).by(1)
        end

        it 'redirects to the games list' do
          post games_url, params: { game: valid_attributes }
          expect(response).to redirect_to(games_url)
          follow_redirect!
          expect(response).to render_template(:index)
          expect(response.body).to include('Le jeu a été créé.')
        end
      end

    end

    describe 'GET game#show' do
      let(:game) { create(:game) }

      it 'should render a successful response' do
        get game_path(game)
        expect(response).to have_http_status(:ok)
        expect(assigns(:game)).to eq(game)
        expect(response).to render_template(:show)
      end
    end

    describe 'GET games#draws' do
      it 'should render a successful response' do
        create_list(:game_draw, 10)
        get games_draws_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:draws)).to eq(GameDraw.order(published_at: :desc))
        expect(response).to render_template(:draws)
      end
    end

    describe 'GET games#new_draw' do
      it 'should render a successful response' do
        get new_game_draw_path
        expect(response).to have_http_status(:ok)
        expect(assigns(:draw)).to be_a(GameDraw)
        expect(response).to render_template(:new_draw)
      end
    end

    describe 'POST games#create_draw' do
      context 'with valid parameters' do
        let(:game) { create(:game)}
        let(:valid_attributes) { attributes_for(:game_draw).merge(game_id: game.id) }

        it 'creates a new Draw' do
          expect do
            post add_draw_url, params: { game_draw: valid_attributes }
          end.to change(GameDraw, :count).by(1)
        end

        it 'redirects to the games draws list' do
          post add_draw_url, params: { game_draw: valid_attributes }
          expect(response).to redirect_to(games_draws_url)
          follow_redirect!
          expect(response).to render_template(:draws)
          expect(response.body).to include('Le tirage a été ajouté.')
        end
      end

    end

  end

end