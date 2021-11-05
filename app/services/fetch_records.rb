class FetchRecords
  prepend SimpleCommand
  include ActiveModel::Validations

  attr_reader :params, :data

  def call
    response = process
    if response['status'] == 200
      @data = response['data']
      OpenStruct.new(status: 200, message: 'Success', data: data)
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
    request = Typhoeus::Request.new(dataset_endpoint, method: :get, body: params.to_json, headers: { 'Content-Type': 'application/json', 'Authorization' => "Bearer #{auth_token}" })
    request.run
    response = request.response
    JSON.parse(response.body)
  end

  def dataset_endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/dataset"
  end

  # Authentication
  def auth_token
    @auth_token ||= RedisManager.backend_auth_token
  end

end