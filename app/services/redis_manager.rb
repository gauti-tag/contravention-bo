class RedisManager

  def self.backend_auth_token
    auth_token = REDIS_CLIENT.get('core:auth_token')
    if auth_token.blank?
      request = Typhoeus::Request.new("#{ENV['CORE_API_ENDPOINT']}/api/platform/auth", method: :post, headers: {'Content-Type' => 'application/json'}, body: {auth: {api_key: Rails.application.credentials.backend[:api_key], api_secret: Rails.application.credentials.backend[:api_secret] }}.to_json)
      request.run
      response = request.response
      if response.code == 200
        auth_token = JSON.parse(response.body)['token']
        REDIS_CLIENT.setex('core:auth_token', 1.hour.to_i, auth_token)
      end
    end
    auth_token
  rescue StandardError => error_obj
    Rails.logger.debug('REDIS ERROR: ' + error_obj)
    ""
  end

end