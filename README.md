- Implement Sentry to Rails Application

#### 1.Installation

adding it to your Gemfile:
```
gem "sentry-raven"
```

#### 2.Configuration

Open up [](config/application.rb) and configure the DSN, and any other [settings](https://docs.sentry.io/clients/ruby/config/) you need

```
# if used is credentials file in the sentry key to use this type
Raven.configure do |config|
  config.dsn = Rails.application.credentials[Rails.env.to_sym][:sentry_url] if Rails.env != 'development'
end

config.filter_parameters << :password
```

```
Raven.configure do |config|
  config.dsn = 'https://*******************************:*******************************@sentry.io/1469301'
end
config.filter_parameters << :password
```

- create sentry.rb to [](config/initializers/sentry.rb) 
```
Raven.configure do |config|
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
```

#### 3.Params and sessions
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