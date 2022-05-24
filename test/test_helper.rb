# frozen_string_literal: true

require "minitest"
require "minitest/autorun"

require "rails"
require "rails/test_help"
require "action_controller/railtie"
require "rails/test_unit/railtie"
require "active_model/railtie"
require "primer/rails_forms"

Dir.chdir("test") do
  require "config/application"

  DummyApplication.initialize!
end

require "view_component/test_helpers"

Dir.chdir("test") do
  Dir["support/**/*.rb"].each do |f|
    require f.chomp(".rb")
  end
end
