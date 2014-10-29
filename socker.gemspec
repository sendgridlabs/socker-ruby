# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'socker/version'

Gem::Specification.new do |spec|
  spec.name          = 'socker'
  spec.version       = Socker::VERSION
  spec.authors       = ['Jonathan Short']
  spec.email         = ['jonathan.short@sendgrid.com']
  spec.summary       = %q{Socker}
  spec.description   = %q{Communicate with socker via a ruby API}
  spec.homepage      = 'https://github.com/sendgridlabs/socker-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_dependency 'hashie', '>= 3.2.0'
  spec.add_dependency 'httpclient', '>= 2.4'
end
