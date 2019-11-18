$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require_relative "lib/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "verify_nexmo_signature"
  spec.version     = VerifyNexmoSignature::VERSION
  spec.authors     = ["Nexmo"]
  spec.email       = ["devrel@nexmo.com"]
  spec.homepage    = "https://github.com/Nexmo/rack-verify-signature-middleware"
  spec.summary     = "This is middleware to verify Nexmo signatures. To use it you\'ll need a Nexmo account. Sign up for free at https://www.nexmo.com"
  spec.description = "Middleware to verify Nexmo signatures"
  spec.license     = "MIT"

  spec.files = Dir["{lib}/**/*", "LICENSE.txt", "README.md"]

  spec.add_runtime_dependency('nexmo', '~> 6.0.1')
  spec.add_runtime_dependency('rack', '~> 2.0', '>= 2.0.7')
  spec.add_development_dependency('simplecov', '~> 0.16')
  spec.add_development_dependency('coveralls', '~> 0.8.15')
  spec.add_development_dependency('rspec', '~> 3.9')

  spec.metadata = {
    'homepage' => 'https://github.com/Nexmo/rack-verify-signature-middleware',
    'source_code_uri' => 'https://github.com/Nexmo/rack-verify-signature-middleware',
    'bug_tracker_uri' => 'https://github.com/Nexmo/rack-verify-signature-middleware/issues',
    'changelog_uri' => 'https://github.com/Nexmo/rack-verify-signature-middleware/blog/master/CHANGES.md'
  }
end

