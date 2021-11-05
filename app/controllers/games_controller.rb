class GamesController < ApplicationController
  before_action :fetch_game, only: [:new, :show, :update]

  def index
    @games = Game.order(created_at: :asc)
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
      api_data = @draw_type.as_json(root: 'request', only: [:name, :drawn_at, :week_day, :bets_end_at, :slug])
      api_data['request']['model'] = 'DrawType'
      SaveRecord.call(api_data)
      flash[:notice] = 'Le type de tirage a été créé.'
      redirect_to draw_types_url
    else
      flash[:alert] = @draw_type.errors.full_messages.join(', ')
      render :new_draw_type
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
      api_data = @draw_type.as_json(root: 'request', only: [:slug, :name, :drawn_at, :week_day, :bets_end_at])
      api_data['request']['model'] = 'DrawType'
      UpdateRecord.call(api_data)
      flash[:notice] = 'Le type de tirage a été modifié.'
      redirect_to draw_types_url
    else
      flash[:alert] = @draw_type.errors.full_messages.join(', ')
      render :show_draw_type
    end
  end

  def new_draw
    @draw = Draw.new
  end

  def create_draw
    @draw = Draw.new(draw_params)
    identifier = "#{@draw.draw_type.slug}-#{@draw.published_at.to_time.to_i}-#{draw_params[:identifier]}"
    @draw.identifier = identifier
    if @draw.save
      api_data = @draw.as_json(root: 'request', only: [:published_at, :identifier, :draw_numbers])
      api_data['request']['model'] = 'Draw'
      api_data['request']['slug'] = @draw.draw_type.slug
      SaveRecord.call(api_data)
      flash[:notice] = 'Le tirage a été ajouté.'
      redirect_to draws_url
    else
      if @draw.errors.include?(:identifier) || @draw.errors.include?(:duplicated_time)
        flash[:warning] = 'Un tirage existe déjà à cette période!'
      else
        flash[:alert] = @draw.errors.full_messages.join(', ')
      end
      redirect_to new_draw_url
    end
  end

  def update_draw
    @draw = Draw.find(params[:draw][:id])
    @draw.assign_attributes(draw_params)
    if @draw.save
      api_data = @draw.as_json(root: 'request', only: [:published_at, :identifier, :draw_numbers])
      api_data['request']['model'] = 'Draw'
      api_data['request']['slug'] = @draw.draw_type.slug
      UpdateRecord.call(api_data)
      flash[:notice] = 'Le tirage a été modifié.'
      redirect_to draws_url
    else
      flash[:alert] = @draw.errors.full_messages.join(', ')
      render :show_draw
    end
  end

  def draws_results
    @draws = Draw.includes(:draw_type).where("draws.draw_numbers != '{}'").order('draws.published_at DESC')
  end

  def draw_result
    today = Date.today
    wday = today.wday
    @week_day = days_labels.fetch(wday.to_s, '')
    @draw_types = DrawType.joins(:draws).where('draw_types.week_day = :wday AND draws.id IS NOT NULL AND draws.published_at = :date', {wday: wday, date: today}).collect { |dt| [dt.title, dt.id, dt.draw_hour, dt.last_identifier] }
    @balls = (1..90).to_a.map { |num| [num, num] }
  end

  def set_draw_result
    draw = Draw.find_by(identifier: draw_params[:identifier])
    draw.update(draw_numbers: draw_params[:draw_numbers])
    api_data = draw.as_json(root: 'request', only: [:published_at, :identifier, :draw_numbers])
    api_data['request']['model'] = 'Draw'
    api_data['request']['slug'] = draw.draw_type.slug
    UpdateRecord.call(api_data)
    flash[:notice] = 'Opération réussie.'
    redirect_to draws_results_url
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
