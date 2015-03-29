require 'Slop'

module AsanaChangeLogger
  OPTS = Slop.parse suppress_errors: true do |o|
    o.integer '-d', '--days', 'Number of days to get', default: 5
    o.integer '-p', '--project', 'Project ID'
    o.string '-o', '--output', 'The output file. Allowed formats: html, md, txt'
    o.string '-a', '--api', 'Store the given API key and start using it from now'
    o.bool '-lr', '--log-remaining', 'Log remainins tasks too', default: false
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