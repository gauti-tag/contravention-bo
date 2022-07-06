module CrudApiManager # Module crud_api_manager
    class UpdateDate < ApplicationService

        attr_reader :params # Make accessible this params to everywhere to classes
      
        # Method to initilize params or value to the class
        def initialize(params)
           @params = params
        end


        def call 

        end


        private 

        
    end
end