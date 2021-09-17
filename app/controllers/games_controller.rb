class GamesController < ApplicationController
  before_action :fetch_game, only: [:new, :show, :update]

  def index
    @games = Game.all
  end

  def new; end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = 'Le jeu a été créé.'
      redirect_to games_url
    else
      flash[:alert] = @game.errors.full_messages.join(', ')
      render :new
    end
  end

  def show; end

  def update
    @game.assign_attributes(game_params)
    if @game.save
      flash[:notice] = 'Le jeu a été modifié.'
      redirect_to game_url(@game)
    else
      flash[:alert] = @game.errors.full_messages.join(', ')
      render :show
    end
  end

  def draws
    @draws = GameDraw.includes(:game).order(published_at: :desc)
  end

  def new_draw
    @draw = GameDraw.new
    @games = Game.all.collect { |g| [g.name, g.id] }
    @balls = (0..100).to_a.map { |num| [num, num] }
  end

  def create_draw
    @draw = GameDraw.new(draw_params)
    if @draw.save
      SaveDraw.call(@draw.as_json(root: 'request', only: [:published_at, :drawn_at, :identifier, :game_id, :balls]))
      flash[:notice] = 'Le tirage a été ajouté.'
      redirect_to games_draws_url
    else
      @games = Game.all.collect { |g| [g.name, g.id] }
      @balls = (0..100).to_a.map { |num| [num, num] }
      if @draw.errors.include?(:identifier)
        flash[:warning] = "Un tirage existe déjà à cette date!"
      else
        flash[:alert] = @draw.errors.full_messages.join(', ')
      end
      render :new_draw
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :rating, :probability, :payout_rating)
  end

  def draw_params
    params.require(:game_draw).permit(:published_at, :drawn_at, :game_id, balls: [])
  end

  def fetch_game
    @game = Game.friendly.find(params[:id])
  rescue StandardError
    @game = Game.new
  end

end
