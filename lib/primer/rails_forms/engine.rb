# frozen_string_literal: true

require "rails/engine"

module Primer
  module RailsForms
    # :nodoc:
    class Engine < ::Rails::Engine
      isolate_namespace Primer::RailsForms

      config.autoload_paths = %W[
        #{root}/lib
      ]
    end
  end
end
