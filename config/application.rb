require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LotoGbAdmin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags  = %i[subdomain uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    config.i18n.default_locale = :fr

    #autoloads lib folder during production
    #config.eager_load_paths << Rails.root.join('lib')

    #autoloads lib folder during development
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app/commands')
    config.autoload_paths << Rails.root.join('app/services')

    config.cache_store = :redis_store, "#{ENV['REDIS_CACHE_URL']}", { expires_in: 90.minutes }
    # This can be put in any of the "environment" files - config/application.rb is just the main
    config.exceptions_app = self.routes
    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'SAMEORIGIN',
      'X-XSS-Protection' => '1; mode=block',
      'X-Content-Type-Options' => 'nosniff'
    }

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
