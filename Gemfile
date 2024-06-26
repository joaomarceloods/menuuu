source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.0"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Flexible authentication solution for Rails with Warden [https://github.com/heartcombo/devise]
gem "devise", "~> 4.8"

# A Ruby library that encodes QR Codes [https://github.com/whomwah/rqrcode]
gem "rqrcode", "~> 2.1"

# An ActiveRecord plugin for managing lists [https://github.com/brendon/acts_as_list]
gem "acts_as_list", "~> 1.0"

gem "tailwindcss-rails", "~> 2.4"

gem "stripe", "~> 11.2.0"

gem "rails-i18n", "~> 7.0.9"
gem "devise-i18n", "~> 1.12.0"

gem "rails_real_favicon"

gem "recaptcha", "~> 5.16.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem 'rspec-rails', '~> 6.1.0'

  gem "launchy", "~> 3.0.1"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "derailed_benchmarks"
  gem "stackprof"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

  # VCR and WebMock for mocking HTTP requests
  gem "vcr", "~> 6.2.0"
  gem "webmock", "~> 3.23.0"

  # Orderly gem for asserting that some text (this) appears before other text (that) in rspec request specs [https://github.com/jmondo/orderly]
  gem "orderly"
end
