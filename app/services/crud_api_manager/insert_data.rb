module CrudApiManager # Module crud_api_manager
    class InsertData < ApplicationService
        INSERT_URI = "/api/admin/contravention/save" # Endpoint of saving record to core  
        attr_reader :params # Make accessible this params to everywhere to classes

        # Method to initilize params or value to the class
        def initialize(params)
            @params = params        
        end
        
        # Method that execute the request to send params to core to be saved
        def call 

            url = ENV['CORE_API_ENDPOINT'].to_s + INSERT_URI
            request = Typhoeus::Request.new(
                url,
                method: :post,
                body: params.to_json,
                headers: {
                    'Content-Type' => 'application/json',
                    'Authorization' => "Bearer #{token}"
                }
            )

            request.run
            response = JSON.parse(request.response.body)
            
            # Check response form the Core and assign a specific response  
            if response['status'] == 201
                @data = response['data']
                OpenStruct.new(message: "Successfull created!", status: 200, data: @data) 
            else
                OpenStruct.new(message: "Operation failed !", status: 400) 
            end
        end
    end
end