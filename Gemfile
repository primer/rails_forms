# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "rubocop", "= 1.13.0"
  gem "rubocop-github", "~> 0.16.0"
  gem "rubocop-performance", "~> 1.7"
end

group :development, :test do
  gem "pry-byebug"
end

group :test do
  gem "capybara"
  gem "minitest"

  rails_version = (ENV["RAILS_VERSION"] || "7.0.3").to_s
  gem "rails", rails_version

  gem "view_component", "~> 2.53"
end
