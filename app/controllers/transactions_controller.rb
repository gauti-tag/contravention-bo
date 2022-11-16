class TransactionsController < ApplicationController 

  def index 
     render params[:model]
  end


  def show 
    model = params[:model]
    result = DatatablesManager::FetchRecord.call(transaction: { model: model_name(model), id: params[:id]} )
    #redirect_back(fallback_location: root_path) if result['status'] != 200
    @record = result['data']
    @back_url = back_url(model)
    render transaction_view(model)
  end

  private

  def transaction_view(name)
    case name
    when 'ticket_payments'
        'show_payment'
    when 'cnis'
        ''
    when 'civil_acts'
        ''
    else
        ''
    end
  end

  def model_name(name)
    {
    'ticket_payments' => 'TrafficTicketPayment',
    'cnis' => 'cnis',
    'civil_acts' => 'civil_acts'
    }.fetch(name)
  end

  def back_url(name)
    "/transactions/contravention/#{name}"
  end


end