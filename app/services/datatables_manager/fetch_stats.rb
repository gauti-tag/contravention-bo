module DatatablesManager
    class FetchStats < ApplicationService
        FETCH_URI = "/api/stats" # Endpoint of fetching statistics to core  

        attr_reader :params # Make accessible this params to everywhere to classes

        # Method to initilize params or value to the class
        def initialize(params)
            @params = params        
        end
        # Method that execute the request to send params to core to be saved
        def call 
            url = ENV['CORE_API_ENDPOINT'].to_s + FETCH_URI + '/' + params[:model_name].to_s
            request = Typhoeus::Request.new(
                url,
                method: :get,
                body: '',
                headers: {
                    'Content-Type' => 'application/json',
                    'Authorization' => "Bearer #{token}"
                }
            )
            request.run
            JSON.parse(request.response.body)
        end
    end
end
