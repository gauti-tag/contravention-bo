require 'csv'
class DatatablesController < ApplicationController
  skip_before_action :access_to_page?
  skip_before_action :authenticate_user!

  def index
    filter_data = params[:filter_data] || {}
    result = FetchRecords.call(params.merge(model_name: model_name, filter_data: filter_data)).result
    render json: result.data.to_h
  end

  def day_draw_types
    week_day = params[:day].to_i
    records = DrawType.where(week_day: week_day).order(name: :asc)
    result = records.map { |draw_type| draw_type.serializable_hash(methods: [:title, :draw_hour]) }
    render json: result
  end

  def draws
    date = Date.parse(params[:date])
    records = Draw.includes(:draw_type).where(published_at: date)
    data = records.map { |draw| draw.serializable_hash(methods: :title) }
    render json: data
  end

  def export_data
    filter_data = params[:filter_data] || {}
    result = FetchExportData.call(params.merge(model_name: model_name, filter_data: filter_data)).result
    render json: {url: result.data}
  end

  def reports
    data = FetchReports.call(draw_id: params[:draw_id]).result.data
    report = {
      bets_sum: data.reduce(0) { |sum, item| sum + item['number_of_bets'].to_i },
      bets_amount: data.reduce(0) { |sum, item| sum + item['amount_of_bets'].to_i },
      winnings_sum: data.reduce(0) { |sum, item| sum + item['number_of_winning_bets'].to_i },
      winnings_amount: data.reduce(0) { |sum, item| sum + item['amount_of_winning_bets'].to_i },
      losings_sum: data.reduce(0) { |sum, item| sum + item['number_of_losing_bets'].to_i },
      losings_amount: data.reduce(0) { |sum, item| sum + item['amount_of_losing_bets'].to_i },
      winnings: data.reduce(0) { |sum, item| sum + item['total_winning_amount'].to_i }
    }

    export_file = "reports-#{params[:draw_id]}.csv"
    CSV.open(Rails.root.join('public', 'reports', export_file), 'wb', headers: true, col_sep: ';') do |csv|
      csv << ['number_of_bets', 'amount_of_bets', 'number_of_winning_bets', 'amount_of_winning_bets', 'number_of_losing_bets', 'amount_of_losing_bets', 'total_winning_amount']
      csv << [report[:bets_sum], report[:bets_amount], report[:winnings_sum], report[:winnings_amount], report[:losings_sum], report[:losings_amount], report[:winnings]]
    end

    render json: { report: report, export: export_file }
  end

  private

  def model_name
    {
      'placed-bets' => 'placed_bets',
      'winning-bets' => 'winning_bets',
      'report-bets' => 'report_bets',
      'bet-payments' => 'bet_payments'
    }.fetch(params[:model], '')
  end

end