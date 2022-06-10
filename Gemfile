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

  # rubocop:disable Bundler/DuplicatedGem
  if rails_version == "main"
    git "https://github.com/rails/rails", ref: "main" do
      gem "rails"
    end
  else
    gem "rails", rails_version
  end
  # rubocop:enable Bundler/DuplicatedGem

  gem "view_component", "~> 2.57"
end
