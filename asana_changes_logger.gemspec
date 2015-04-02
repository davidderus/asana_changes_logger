# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asana_change_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "asana_change_logger"
  spec.version       = AsanaChangeLogger::VERSION
  spec.authors       = ["David Dérus"]
  spec.email         = ["derus.david@gmx.fr"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = "Export Asana tasks to a structured changelog"
  spec.homepage      = "http://davidderus.com"
  spec.license       = "MIT"

  spec.files         = ['lib/asana_change_logger.rb', 'lib/asana_change_logger/asana.rb', 'lib/asana_change_logger/cli.rb', 'lib/asana_change_logger/export.rb', 'lib/asana_change_logger/config.rb', 'lib/asana_change_logger/version.rb', 'lib/asana_change_logger/tpl/tasks.html.erb', 'lib/asana_change_logger/tpl/tasks.txt.erb', 'lib/asana_change_logger/tpl/tasks.md.erb']
  spec.bindir        = "bin"
  spec.executables   = ['asana_change_logger']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"

  spec.add_dependency "slop", "~> 4.0.0"
end
