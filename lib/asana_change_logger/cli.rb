require 'Slop'
require_relative 'asana'
require_relative 'export'

module AsanaChangeLogger
  opts = Slop.parse do |o|
    o.string '-h', '--host', 'a hostname'
    o.integer '--port', 'custom port', default: 80
    o.on '--version', 'print the version' do
      puts AsanaChangeLogger::VERSION
      exit
    end
  end
end