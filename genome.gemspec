# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'genome/version'

Gem::Specification.new do |spec|
  spec.name          = 'genome'
  spec.version       = Genome::VERSION
  spec.authors       = ['hypernova2002']
  spec.email         = ['hypernova2002@gmail.com']

  spec.summary       = %q{A library for create and maintaining cloud formation stacks}
  spec.description   = %q{A library for create and maintaining cloud formation stacks}
  spec.homepage      = 'https://github.com/hypernova2002/genome'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'aws-sdk-cloudformation', '~> 1.8'
  spec.add_dependency 'activesupport', '~> 5.2'

  spec.add_development_dependency 'bundler', '~> 1.14'
  # TODO: Remove foreman
  spec.add_development_dependency 'foreman'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
