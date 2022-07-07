module CrudApiManager

    class DeleteData < ApplicationService
        
        attr_reader :params

        DELETE_URI = "/api/admin/contravention/delete"

        def initialize(params)
            @params = params
        end

        def call
           url = ENV['CORE_API_ENDPOINT'].to_s + DELETE_URI

           request = Typhoeus::Request.new(
            url,
            method: :post,
            body: params.to_json,
            headers: 
            {
              'Content-Type' => 'application/json',
               'Authorization' => "Bearer #{token}"
            }
           )

           request.run 
           response = JSON.parse(request.response.body)
           
           if response['status'] == 200
                OpenStruct.new(status: :no_content, message: "data successfully deleted !")
           else
               errors.add(:operation, 'Operation failed !')
           end
        end

    end

end