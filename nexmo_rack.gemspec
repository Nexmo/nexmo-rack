$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require_relative "lib/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "nexmo_rack"
  spec.version     = Nexmo::Rack::VERSION
  spec.authors     = ["Nexmo"]
  spec.email       = ["devrel@nexmo.com"]
  spec.homepage    = "https://github.com/Nexmo/nexmo-rack"
  spec.summary     = "Nexmo related middleware to make it easier to work with Nexmo's webhooks. To use it you'll need a Nexmo account. Sign up for free at https://dashboard.nexmo.com/sign-up"
  spec.description = "Nexmo related middleware to make it easier to work with Nexmo's webhooks"
  spec.license     = "MIT"

  spec.files = Dir["{lib}/**/*", "LICENSE.txt", "README.md"]

  spec.add_runtime_dependency('nexmo', '~> 6.1')
  spec.add_runtime_dependency('rack', '~> 2.0', '>= 2.0.7')
  spec.add_development_dependency('simplecov', '~> 0.16')
  spec.add_development_dependency('coveralls', '~> 0.8.15')
  spec.add_development_dependency('rspec', '~> 3.9')

  spec.metadata = {
    'homepage' => 'https://github.com/Nexmo/nexmo_rack',
    'source_code_uri' => 'https://github.com/Nexmo/nexmo_rack',
    'bug_tracker_uri' => 'https://github.com/Nexmo/nexmo_rack/issues',
    'changelog_uri' => 'https://github.com/Nexmo/nexmo_rack/blob/master/CHANGES.md'
  }
end

