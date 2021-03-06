require 'asana_changes_logger/version'
require 'asana_changes_logger/cli'
require 'asana_changes_logger/asana'
require 'asana_changes_logger/export'
require 'asana_changes_logger/config'

module AsanaChangesLogger
  class Worker
    def initialize
      cli = CLI.new
      conf = Config.new

      if cli.opts[:api]
        conf.set_api_key(cli.opts[:api])
      end

      if cli.opts[:project] && cli.opts[:days]
        # Checking for auth
        conf.auth?

        # Connecting
        asana = Asana.new(conf.get_api_key)

        # Getting tasks
        project_tasks = asana.get_project_tasks(cli.opts[:project], completed_since: cli.opts[:days], completed_start: cli.opts[:start], show_sections: cli.opts[:sections])

        # Outputing
        export = Exporter.new(project_tasks, cli, asana)

        if cli.opts[:'log-remaining']
          export.append_remaining asana.get_remaining_tasks(cli.opts[:project], show_sections: cli.opts[:sections])
        end

        if cli.opts[:output]
          # Should store output in file
          export.save
        else
          # Should print output to screen
          export.to_term
        end
      else
        puts 'You have to specify a project ID and a number of days (0 or more).'
      end
    end
  end
end
