class DatatablesController < ApplicationController
  skip_before_action :has_access_to_page?
  skip_before_action :authenticate_user!
  
  def index
    filter_data = params[:filter_data] || {}
    result = FetchRecords.call(params.merge(model_name: get_model_name, filter_data: filter_data)).result
    render json: result.data.to_h
  end

  def day_draw_types
    week_day = params[:day].to_i
    records = DrawType.where(week_day: week_day).order(name: :asc)
    result = []
    records.each do |record|
      result << record.serializable_hash(methods: [:title, :draw_hour])
    end
    render json: result
  end

  private

  def get_model_name
    {
      'placed-bets' => 'placed_bets',
      'winning-bets' => 'winning_bets',
      'bet-payments' => 'bet_payments'
    }.fetch(params[:model], '')
  end

end