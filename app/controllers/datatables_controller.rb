class DatatablesController < ApplicationController 

    def index 
        filter_data = params[:filter_data] || {}
        result = DatatablesManager::FetchRecords.call(params.merge(model_name: model_name, filter_data: filter_data))
        render json: result['data']
    end


    private 

    def model_name
        {
          'ticket_payments' => 'ticket_payments',
          'cnis' => 'cnis',
          'civil_acts' => 'civil_acts'
        }.fetch(params[:model], '')
    end
end