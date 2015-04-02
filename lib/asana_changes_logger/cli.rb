require 'Slop'

module AsanaChangesLogger
  class CLI
    attr_reader :opts

    def initialize
      @opts = Slop.parse suppress_errors: true do |o|
        o.integer '-d', '--days', 'Number of days to get including today (default: 5)', default: 5
        o.integer '-s', '--start', 'Number of days in the past to start from (default: 0 for today)', default: 0
        o.integer '-p', '--project', 'Project ID'
        o.string '-o', '--output', 'The output file. Allowed formats: html, md, txt'
        o.string '-a', '--api', 'Store the given API key and start using it from now'
        o.bool '-lr', '--log-remaining', 'Log remainins tasks too', default: false
        o.bool '-ha', '--hide-author', 'Hide task assignee from changelog', default: false
        o.bool '--sections', 'Show sections in changelog', default: false
        o.on '-v', '--version', 'Print the current version' do
          puts AsanaChangesLogger::VERSION
          exit
        end
        o.on '-h', '--help', 'Print help' do
          puts o
          exit
        end
      end
    end
  end
end