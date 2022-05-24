# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "primer/rails_forms/version"

Gem::Specification.new do |spec|
  spec.name          = "primer_rails_forms"
  spec.version       = Primer::RailsForms::VERSION::STRING
  spec.authors       = ["GitHub Open Source"]
  spec.email         = ["opensource+primer_view_components@github.com"]

  spec.summary       = "Primer forms framework for Rails"
  spec.homepage      = "https://github.com/primer/rails_forms"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*", "app/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "primer_view_components"
  spec.add_runtime_dependency "railties", ">= 7"
end
