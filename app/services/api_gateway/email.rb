require 'typhoeus'
require 'json'
require "ostruct"
module ApiGateway
    class Email
        EMAIL_URI = '/push/transactional'
        def self.push(email, subject, body) 
            request = Typhoeus::Request.new(
                ENV['API_EMAIL_URL'] + EMAIL_URI,
                method: :post,
                headers: {'Content-Type' => 'application/json'},
                body: body(email, subject, body).to_json
            )

            request.run
            response = JSON.parse(request.response.body, symbolize_names: true)
            OpenStruct.new(status: response[:status], message: response[:description], errors: response[:errors])
        end
        
        private

        def self.body(email_address, subject_content, body_content)
            {
                email: email_address,
                subject: subject_content,
                body: body_content
            }
        end
    end
end