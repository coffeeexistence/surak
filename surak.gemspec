# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'surak/version'

Gem::Specification.new do |spec|
  spec.name          = "surak"
  spec.version       = Surak::VERSION
  spec.authors       = ["John Anthony Rivera"]
  spec.email         = ["askinganthony@gmail.com"]

  spec.summary       = "Ruby Gem for surak, a quick and easy platform for creating production-ready angular apps."
  spec.homepage      = "https://github.com/coffeeexistence/surak"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["surak"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "filewatcher", "~> 0.5.3"
  spec.add_dependency "parallel", "~> 1.8.0"
  spec.add_dependency "webrick", "~> 1.3.1"
end
