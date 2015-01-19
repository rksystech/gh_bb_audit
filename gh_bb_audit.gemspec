# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gh_bb_audit/version'

Gem::Specification.new do |spec|
  spec.name        = "github_bitbucket_audit"
  spec.version     = GhBbAudit::VERSION
  spec.summary     = "Looks for specific keywords in the public repos of github and bitbucket"
  spec.date        = "2014-04-01"
  spec.description = "The library takes a list of users and searches their public repos for specific keywords"
  spec.authors     = ["Rajiv"]
  spec.email       = ["rkapil@systango.com"]
  spec.homepage    = "http://systango.com/"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "github_api", "~> 0.11.3"
  spec.add_dependency "bitbucket_rest_api", "~> 0.1.6"
  spec.add_dependency 'semantic_logger', '~> 2.7.0'
	
  spec.add_development_dependency "pry"
end