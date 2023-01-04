module DatatablesManager
    class FetchExportData < ApplicationService
        
            FETCH_URI = "/api/dataset/export"

            attr_reader :params

        def initialize(params)
            @params = params
        end

        def call 
            url = ENV['CORE_API_ENDPOINT'].to_s + FETCH_URI
            request = Typhoeus::Request.new(
                url,
                method: :get,
                body: params.to_json,
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