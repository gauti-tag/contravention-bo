class LotoController < ApplicationController
  
  def transactions
    render params[:model_name]
  end

  def show_transaction
    result = FetchRecord.call(request: {model: get_model_name(params[:model_name]), id: params[:id]}).result
    redirect_back(fallback_location: root_path) if result.status != 200
   
    @record = result.data
    @back_url = "/loto/transactions/#{params[:model_name]}"
    render transaction_view(params[:model_name])
  end

  def transaction_view(model_name)
    case model_name
    when 'placed-bets', 'winning-bets'
      'show_bet'
    when 'bet-payments'
      'show_payment'
    end
  end

  def get_model_name(model_name)
    {
      'placed-bets' => 'LotoBet',
      'winning-bets' => 'LotoBet',
      'bet-payments' => 'BetPayment'
    }.fetch(model_name, '')
  end
end