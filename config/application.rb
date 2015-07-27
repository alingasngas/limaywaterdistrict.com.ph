require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module LimayWaterDistrict
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
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    config.assets.initialize_on_precompile = false
    config.assets.raise_runtime_errors = false

    config.time_zone = 'Asia/Taipei'

    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation, :card_number, :card_expiry_month, :card_expiry_year]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    config.active_record.schema_format = :sql

    config.action_mailer.delivery_method   = :smtp
    config.action_mailer.smtp_settings = { :address => "mail.inbox.com.ph",
                                           :port => 587,
                                           :enable_starttls_auto => true,
                                           :user_name => ENV['GMAIL_USERNAME'],
                                           :password => ENV['GMAIL_PASSWORD'],
                                           :openssl_verify_mode  => 'none',
                                           :authentication => 'plain',
                                           :domain => 'mariwad.com.ph'
    }

    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
  end
end
