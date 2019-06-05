require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsSentry
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.filter_parameters << :password

    Raven.configure do |config|
      # if used to credentials file to access these method
      # config.dsn = Rails.application.credentials[Rails.env.to_sym][:sentry_url] if Rails.env != 'development'
      config.dsn = 'https://*******************************:*******************************@sentry.io/1469301'
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
