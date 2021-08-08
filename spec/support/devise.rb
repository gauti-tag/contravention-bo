require_relative './request_macros'

RSpec.configure do |config|
  # For Devise > 4.1.1
  # config.include Devise::Test::ControllerHelpers, :type => :controller
  # Use the following instead if you are on Devise <= 4.1.1
  # config.include Devise::TestHelpers, :type => :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.extend RequestMacros, :type => :request
end