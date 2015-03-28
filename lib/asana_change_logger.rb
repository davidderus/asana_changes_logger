require 'asana_change_logger/version'
require 'asana_change_logger/cli'
require 'asana_change_logger/asana'
require 'asana_change_logger/config'
require 'asana_change_logger/export'

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
    project_tasks = asana.get_project_tasks(AsanaChangeLogger::OPTS[:project], AsanaChangeLogger::OPTS[:days])

    # Outputing
    export = Exporter.new(project_tasks)

    if AsanaChangeLogger::OPTS[:'log-remaining']
      export.append_remaining asana.get_remaining_tasks(AsanaChangeLogger::OPTS[:project])
    end

    if AsanaChangeLogger::OPTS[:output]
      # Should store output in file
      export.save(AsanaChangeLogger::OPTS[:output], AsanaChangeLogger::OPTS[:format])
    else
      # Should print output to screen
      export.to_term
    end
  end
end
