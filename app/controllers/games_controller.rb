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
    @draws = Draw.includes(:draw_type).order(published_at: :desc)
  end

  def draw_types
    @draw_types = DrawType.order(created_at: :desc)
  end

  def new_draw_type
    @draw_type = DrawType.new
  end

  def create_draw_type
    params[:draw_type][:week_day] = params[:draw_type][:week_day].to_i
    @draw_type = DrawType.new(draw_type_params)
    if @draw_type.save
      SaveDrawType.call(@draw_type.as_json(root: 'request', only: [:name, :drawn_at, :week_day, :bets_end_at]))
      flash[:notice] = 'Le type de tirage a été créé.'
      redirect_to draw_types_url
    else
      flash[:alert] = @draw_type.errors.full_messages.join(', ')
      render :new
    end
  end

  def show_draw_type
    @draw_type = DrawType.find(params[:id])
  end

  def update_draw_type
    params[:draw_type][:week_day] = params[:draw_type][:week_day].to_i
    @draw_type = DrawType.find(params[:draw_type][:id])
    @draw_type.assign_attributes(draw_type_params)
    if @draw_type.save
      flash[:notice] = 'Le type de tirage a été modifié.'
      redirect_to draw_types_url
    else
      flash[:alert] = @draw_type.errors.full_messages.join(', ')
      render :show_draw_type
    end
  end

  def new_draw
    @draw = Draw.new
    today = Time.now.wday
    @week_day = days_labels.fetch(today.to_s, '')
    @draw_types = DrawType.includes(:draws).where('draw_types.week_day = ?', today).collect { |dt| [dt.title, dt.id, dt.draw_hour, dt.draws.count + 1] }
    @balls = (1..90).to_a.map { |num| [num, num] }
  end

  def create_draw
    @draw = Draw.new(draw_params)
    identifier = @draw.published_at.to_time.to_i.to_s + '-' + @draw.draw_type_id.to_s + '-' + draw_params[:identifier].to_s
    @draw.identifier = identifier
    if @draw.save
      SaveDraw.call(@draw.as_json(root: 'request', only: [:published_at, :draw_type_id, :identifier, :draw_numbers]))
      flash[:notice] = 'Le tirage a été ajouté.'
      redirect_to draws_url
    else
      today = Time.now.wday
      @week_day = days_labels.fetch(today.to_s, '')
      @draw_types = DrawType.includes(:draws).where('draw_types.week_day = ?', today).collect { |dt| [dt.title, dt.id, dt.draw_hour, dt.draws.count + 1] }
      @balls = (1..90).to_a.map { |num| [num, num] }
      if @draw.errors.include?(:identifier)
        flash[:warning] = "Un tirage existe déjà à cette date!"
      else
        flash[:alert] = @draw.errors.full_messages.join(', ')
      end
      render :new_draw
    end
  end

  def update_draw
    @draw = Draw.find(params[:draw][:id])
    @draw.assign_attributes(draw_params)
    if @draw.save
      flash[:notice] = 'Le tirage a été modifié.'
      redirect_to draws_url
    else
      flash[:alert] = @draw.errors.full_messages.join(', ')
      render :show_draw
    end
  end

  private

  def days_labels
    {
      '0' => 'Dimanche',
      '1' => 'Lundi',
      '2' => 'Mardi',
      '3' => 'Mercredi',
      '4' => 'Jeudi',
      '5' => 'Vendredi',
      '6' => 'Samedi'
    }
  end

  def game_params
    params.require(:game).permit(:name, :rating, :probability, :payout_rating, :numbers_limit)
  end

  def draw_type_params
    params.require(:draw_type).permit(:name, :week_day, :bets_end_at, :drawn_at)
  end

  def draw_params
    params.require(:draw).permit(:identifier, :published_at, :draw_type_id, draw_numbers: [])
  end

  def fetch_game
    @game = Game.friendly.find(params[:id])
  rescue StandardError
    @game = Game.new
  end

end
