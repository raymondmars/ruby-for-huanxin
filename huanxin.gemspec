# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huanxin/version'

Gem::Specification.new do |spec|
  spec.name          = "huanxin"
  spec.version       = Huanxin::VERSION
  spec.authors       = ["Robot Jiang"]
  spec.email         = ["robot.z.jiang@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Huanxin Rest API for Ruby Client}
  spec.description   = %q{环信 Rest API 的 Ruby Client }
  spec.homepage      = "https://github.com/RobotJiang/ruby-for-huanxin"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.6" 
  spec.add_development_dependency "httparty", "~> 0.13.3"
  spec.add_development_dependency "activesupport"
end
