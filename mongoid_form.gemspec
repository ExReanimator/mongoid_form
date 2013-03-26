# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_form/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_form"
  spec.version       = MongoidForm::VERSION
  spec.authors       = ["Ivan Teplyakov"]
  spec.email         = ["exreanimator@gmail.com"]
  spec.description   = %q{Form builder for apps which use mongoid}
  spec.summary       = %q{It makes your life easy when you develop forms and your apps uses mongoid}
  spec.homepage      = "https://github.com/ExReanimator/mongoid_form"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'mongoid',    '>= 2.4'
  spec.add_dependency 'actionpack', '>= 3.1'
  spec.add_dependency 'activesupport', '>= 3.1'
  spec.add_dependency 'rails', '>= 3.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
