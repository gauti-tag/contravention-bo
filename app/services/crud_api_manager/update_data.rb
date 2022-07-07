module CrudApiManager # Module crud_api_manager
    class UpdateData < ApplicationService
        
        UPDATE_URI = "/api/admin/contravention/update"
        attr_reader :params # Make accessible this params to everywhere to classes
      
        # Method to initilize params or value to the class
        def initialize(params)
           @params = params
        end

        # Method that execute the request to send params to core to be updeted
        def call 

            url = ENV['CORE_API_ENDPOINT'].to_s + UPDATE_URI
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
            if response['status'] == 201
                @data_updated = response['data']
                OpenStruct.new(status: 200, message: "Updated successfully", data: @data_updated)
            else
                #errors.add(:operation, 'Openration failed !')
                OpenStruct.new(status: 400, message: 'Operation Failed', response: response)
            end

        end

        
    end
end