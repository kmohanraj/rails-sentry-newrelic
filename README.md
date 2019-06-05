### Implement Sentry Raven to Rails Application

#### 1.Installation

adding it to your Gemfile:
```
gem "sentry-raven"
```

#### 2.Configuration

[Open up](config/application.rb) and configure the DSN, and any other [settings](https://docs.sentry.io/clients/ruby/config/) you need

```
# if used is credentials file in the sentry key to use this type
Raven.configure do |config|
  config.dsn = Rails.application.credentials[Rails.env.to_sym][:sentry_url] if Rails.env != 'development'
end

config.filter_parameters << :password
```

##### DSN add to [application.rb](config/application.rb)
```
Raven.configure do |config|
  config.dsn = 'https://*******************************:*******************************@sentry.io/1469301'
end
config.filter_parameters << :password
```

##### create [sentry.rb](config/initializers/sentry.rb) 
```
Raven.configure do |config|
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
```

#### 3.Params and sessions added application controller [application_controller.rb](app/controllers/application_controller.rb)
```
class ApplicationController < ActionController::Base
  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
```

### Implemet New Relic 

#### 1. Installation

adding it to your Gemfile
```
# To monitor your applications in production
gem 'newrelic_rpm'
```

#### 2.Configuration

To monitor your applications in production, create an account at http://newrelic.com/ . There you can sign up for a free Lite account or one of our paid subscriptions.

##### create a file for [newrelic.yml](config/newrelic.yml)

```
common: &default_settings
  # if use credentials in license key
  # license_key: <%= Rails.application.credentials[:new_relic_key] %>
  license_key: ""
  log_level: info

development:
  <<: *default_settings
  app_name: New Relic (DEV)
  monitor_mode: false
  agent_enabled: false
  distributed_tracing.enabled: false
  dispatcher: 'puma'

test:
  <<: *default_settings
  app_name: New Relic (Test)
  monitor_mode: false
  agent_enabled: false
  distributed_tracing.enabled: false
  dispatcher: 'puma'

production:
  <<: *default_settings
  app_name: New Relic  (Prod)
  monitor_mode: true
  distributed_tracing.enabled: true
  dispatcher: 'puma'


```


