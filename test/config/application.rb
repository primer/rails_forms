# frozen_string_literal: true

class DummyApplication < ::Rails::Application
  config.eager_load = false
  config.active_support.deprecation = :stderr
end

require "view_component"
require "primer/view_components/engine"
