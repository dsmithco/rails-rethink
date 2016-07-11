require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsRethink
  class Application < Rails::Application
    config.assets.precompile << Proc.new { |path|
      if path =~ /\.(eot|svg|ttf|woff)\z/
        true
      end
    }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
