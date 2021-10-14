class SaveRecord
  prepend SimpleCommand
  include ActiveModel::Validations

  attr_reader :params

  def call
    response = process
    if response['status'] == 201
      OpenStruct.new(status: 200, message: 'Success', data: params)
    else
      errors.add(:operation, 'Request failed!')
      OpenStruct.new(response)
    end
  end

  private

  def initialize(params)
    @params = params
  end

  def process
    request = Typhoeus::Request.new(endpoint, method: :post, body: params.to_json, headers: { 'Content-Type': 'application/json', 'Authorization' => "Bearer #{auth_token}" })
    request.run
    response = request.response
    JSON.parse(response.body)
  end

  def endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/admin/save"
  end

  # Authentication
  def auth_token
    @auth_token ||= RedisManager.backend_auth_token
  end

end