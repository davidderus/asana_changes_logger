require 'Slop'
require 'asana'
require 'export'

module AsanaChangeLogger
  opts = Slop.parse do |o|
    o.string '-h', '--host', 'a hostname'
    o.integer '--port', 'custom port', default: 80
    o.on '--version', 'print the version' do
      puts Slop::VERSION
      exit
    end
  end
end