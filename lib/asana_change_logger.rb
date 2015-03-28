require 'asana_change_logger/version'
require 'asana_change_logger/cli'
require 'asana_change_logger/asana'
require 'asana_change_logger/export'
require 'asana_change_logger/config'

module AsanaChangeLogger

  def self.auth?
    defined?(APP_CONFIG) && APP_CONFIG[:api_key]
  end

  if AsanaChangeLogger::OPTS[:project] && AsanaChangeLogger::OPTS[:days]
    # Checking for auth
    raise 'Auth error' unless auth?
    # Should get tasks for said days
    Asana.new(APP_CONFIG[:api_key]).get_project_tasks(AsanaChangeLogger::OPTS[:project], AsanaChangeLogger::OPTS[:days]).filter_by_ended
    if AsanaChangeLogger::OPTS[:output]
      # Should store output in file
    else
      # Should print output to screen
    end
  end
end
