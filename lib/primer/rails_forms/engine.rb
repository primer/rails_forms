# frozen_string_literal: true

require "rails/engine"

module Primer
  module RailsForms
    class Engine < ::Rails::Engine
      isolate_namespace Primer::RailsForms

      config.autoload_paths = %W[
        #{root}/lib
      ]

      config.eager_load_paths = %W[
        #{root}/lib
      ]

      initializer "primer_rails_forms.eager_load_actions" do
        ActiveSupport.on_load(:after_initialize) do
          Primer::RailsForms::BaseComponent.descendants.each(&:compile!) if Rails.application.config.eager_load
        end
      end
    end
  end
end
