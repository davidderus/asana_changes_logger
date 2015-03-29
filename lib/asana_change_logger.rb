require 'asana_change_logger/version'
require 'asana_change_logger/cli'
require 'asana_change_logger/asana'
require 'asana_change_logger/export'
require 'asana_change_logger/config'

module AsanaChangeLogger

  conf = Config.new

  if OPTS[:api]
    conf.set_api_key(OPTS[:api])
  end

  if OPTS[:project] && OPTS[:days]
    # Checking for auth
    conf.auth?

    # Connecting
    asana = Asana.new(conf.get_api_key)

    # Getting tasks
    project_tasks = asana.get_project_tasks(OPTS[:project], OPTS[:days])

    # Outputing
    export = Exporter.new(project_tasks)

    if OPTS[:'log-remaining']
      export.append_remaining asana.get_remaining_tasks(OPTS[:project])
    end

    if OPTS[:output]
      # Should store output in file
      export.save(OPTS[:output])
    else
      # Should print output to screen
      export.to_term
    end
  else
    puts 'You have to specify a project ID and a number of days (0 or more).'
  end
end
