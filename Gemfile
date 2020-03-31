# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.5"

gem "decidim", "0.20.0"
# gem "decidim-consultations", "0.20.0"
# gem "decidim-initiatives", "0.20.0"

gem "bootsnap", "~> 1.3"

gem "puma", "~> 3.12.2"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.9"
gem "figaro"
gem "decidim-decidim_awesome", git: "https://github.com/Platoniq/decidim-module-decidim_awesome"
group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", "0.20.0"
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem 'capistrano-rbenv', '~> 2.1', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.6', require: false
  gem 'capistrano-rails-console', require: false
  gem 'capistrano3-puma', require: false
end

group :production do
  gem "passenger"
  gem 'delayed_job_active_record'
  gem "daemons"
end

