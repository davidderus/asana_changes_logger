require 'asana_change_logger/version'
require 'asana_change_logger/cli'
require 'asana_change_logger/asana'
require 'asana_change_logger/config'
require 'asana_change_logger/export'


=begin
 - name for global tag (instead of 'General')
 - set/update asana auth
 - show message on unknown argument (and handle exceptions everywhere)
 - write tests (it's never too late)
=end

module AsanaChangeLogger

  def self.auth?
    defined?(APP_CONFIG) && APP_CONFIG[:api_key]
  end

  if OPTS[:project] && OPTS[:days]
    # Checking for auth
    raise 'Auth error' unless auth?

    # Connecting
    asana = Asana.new(APP_CONFIG[:api_key])

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
