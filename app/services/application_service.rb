require 'typhoeus' # Ruby Gem or Library to perform HTTP request
require 'json' # Librabry to deal wth JSON
require "ostruct" # Library to data structure (Hash)
class ApplicationService # mother class for services
    TOKEN_URI = "/platform/auth"  # Endpoint to be authenticated to Core 
    
    # Method to be Call when using classes
    def self.call(params)
        new(params).call
    end



    protected # All methods above become protected to other class
    # Method to get the auth token from the Core
    def token
        url = ENV['CORE_API_ENDPOINT'].to_s + TOKEN_URI

        request = Typhoeus::Request.new(
            url,
            method: :post,
            body: auth_params.to_json,
            headers: {
                'Content-Type': 'application/json'
            }
        )

        request.run
        response = JSON.parse(request.response.body)
        token ||= response['token']
        token
    end
    
    # Method that handle credentials giving by the Core to be authenticated
    def auth_params
    {
        auth: {
            api_key: ENV['CORE_API_KEY'],
            api_secret: ENV['CORE_API_SECRET']
        }
    }
    end
end