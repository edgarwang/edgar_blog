require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# TODO: when update to rails4.1.0, this should be removed
require "action_view/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module EdgarBlogs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # disable some unused middleware
    config.middleware.delete 'Rack::Cache'
    config.middleware.delete 'Rack::Lock'
    config.middleware.delete 'ActionDispatch::RequestId'
    config.middleware.delete 'ActionDispatch::RemoteIp'

    # disable field_with_errors wrapper
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      "#{html_tag}".html_safe 
    }
    
    config.autoload_paths += %W(#{config.root}/lib)

    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end

# Load lib/markdown.rb for rendering code blocks
require 'markdown'
