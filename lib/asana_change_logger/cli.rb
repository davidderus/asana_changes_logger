require 'Slop'

module AsanaChangeLogger
  OPTS = Slop.parse do |o|
    o.integer '-d', '--days', 'Number of days to get', default: 5
    o.string '-o', '--output', 'The output file'
    o.on '-v', '--version', 'Print the current version' do
      puts AsanaChangeLogger::VERSION
      exit
    end
    o.on '-h', '--help', 'Print help' do
      puts o
      exit
    end
  end
end