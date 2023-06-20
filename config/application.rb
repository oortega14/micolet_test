# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MicoletTest
  # MicoletTest::Application is the main application class for the MicoletTest application.
  # It inherits from Rails::Application and provides the application-specific configuration.
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    config.generators.template_engine = :slim
    config.cache_store = :memory_store, { size: 64.megabytes }
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'views', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = %i[en es de fr]
    config.i18n.default_locale = :en
    config.autoload_paths << "#{Rails.root}/app/exceptions"
    config.active_job.queue_adapter = :sidekiq
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
