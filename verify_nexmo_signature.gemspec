$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "lib/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "verify_nexmo_signature"
  spec.version     = VerifyNexmoSignature::VERSION
  spec.authors     = ["Nexmo"]
  spec.email       = ["devrel@nexmo.com"]
  spec.homepage    = "https://github.com/Nexmo/verify-nexmo-signature"
  spec.summary     = "This is middleware to verify Nexmo signatures. To use it you\'ll need a Nexmo account. Sign up for free at https://www.nexmo.com"
  spec.description = "Middleware to verify Nexmo signatures"
  spec.license     = "MIT"

  spec.files = Dir["{lib}/**/*", "LICENSE.txt", "README.md"]

  spec.add_dependency('jwt', '~> 2')
  spec.add_dependency('digest', '~> 2.7.6')
  spec.add_development_dependency('simplecov', '~> 0.16')
  spec.add_development_dependency('coveralls', '~> 0.8.15')

  spec.metadata = {
    'homepage' => 'https://github.com/Nexmo/verify-nexmo-signature',
    'source_code_uri' => 'https://github.com/Nexmo/verify-nexmo-signature',
    'bug_tracker_uri' => 'https://github.com/Nexmo/verify-nexmo-signature/issues',
    'changelog_uri' => 'https://github.com/Nexmo/verify-nexmo-signature/blog/master/CHANGES.md'
}
end
