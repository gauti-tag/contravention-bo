class DatatablesController < ApplicationController
  skip_before_action :has_access_to_page?
  skip_before_action :authenticate_user!
  
  def placed_bets
    result = FetchRecords.call(params.merge(model_name: 'placed_bets', filter_data: {})).result
    render json: result.data.to_h
  end

  def winning_bets
    result = FetchRecords.call(params.merge(model_name: 'winning_bets', filter_data: {})).result
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

end