require 'asana_change_logger/version'
require 'asana_change_logger/cli'
require 'asana_change_logger/asana'
require 'asana_change_logger/config'

module AsanaChangeLogger

  def self.auth?
    defined?(APP_CONFIG) && APP_CONFIG[:api_key]
  end

  if AsanaChangeLogger::OPTS[:project] && AsanaChangeLogger::OPTS[:days]
    # Checking for auth
    raise 'Auth error' unless auth?
    # Connecting
    asana = Asana.new(APP_CONFIG[:api_key])
    # Getting tasks
    asana.get_project_tasks(AsanaChangeLogger::OPTS[:project], AsanaChangeLogger::OPTS[:days])
    # Outputing
    if AsanaChangeLogger::OPTS[:output]
      if AsanaChangeLogger::OPTS[:'log-remaining']
        asana.get_remaining_tasks(AsanaChangeLogger::OPTS[:project])
      end
      # Should store output in file
    else
      # Should print output to screen
    end
  end
end
