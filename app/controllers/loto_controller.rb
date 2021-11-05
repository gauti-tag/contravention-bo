class LotoController < ApplicationController
  
  def transactions
    render params[:model_name]
  end

  def show_transaction
    name_param = params[:model_name]
    result = FetchRecord.call(request: {model: model_name(name_param), id: params[:id]}).result
    redirect_back(fallback_location: root_path) if result.status != 200

    @record = result.data
    @back_url = back_url(name_param)
    render transaction_view(name_param)
  end

  def reports; end

  private

  def transaction_view(name)
    case name
    when 'placed-bets', 'winning-bets', 'report-bets'
      'show_bet'
    when 'bet-payments'
      'show_payment'
    end
  end

  def model_name(name)
    {
      'placed-bets' => 'LotoBet',
      'winning-bets' => 'LotoBet',
      'report-bets' => 'LotoBet',
      'bet-payments' => 'BetPayment'
    }.fetch(name, '')
  end

  def back_url(name)
    return '/loto/reports' if name == 'report-bets'

    "/loto/transactions/#{name}"
  end
  
end