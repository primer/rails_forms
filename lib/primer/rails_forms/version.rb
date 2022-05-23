# frozen_string_literal: true

module Primer
  module RailsForms
    module VERSION
      MAJOR = 0
      MINOR = 1
      PATCH = 0

      STRING = [MAJOR, MINOR, PATCH].join(".")
    end
  end
end

# rubocop:disable Rails/Output
puts Primer::ViewComponents::VERSION::STRING if __FILE__ == $PROGRAM_NAME
# rubocop:enable Rails/Output
