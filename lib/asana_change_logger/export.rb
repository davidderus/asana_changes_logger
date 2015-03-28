require 'erb'

module AsanaChangeLogger
  class Exporter

    def initialize(tasks)
      @list_tasks = tasks
      @as_tasks = []
      objectify @list_tasks, @as_tasks
    end


    def objectify(source, dest)
      source.each { |task| dest << Asana::Task.new(task) }
    end


    def group_by(key)

    end


    def append_remaining(remaining_source)
      @remaining_tasks = []
      objectify remaining_source, @remaining_tasks
    end


    def remaining?
      @remaining_tasks && @remaining_tasks.length > 0
    end


    def ready?
      @as_tasks && @as_tasks.length > 0
    end


    def to_markdown
      raise 'Not ready' unless ready?
      
      render('tasks.md')
    end


    def to_html
      raise 'Not ready' unless ready?
      
      render('tasks.html')
    end


    def to_plaintext
      raise 'Not ready' unless ready?
      
      render('tasks.txt')
    end


    def to_term
      puts to_plaintext
    end


    def save(dest, format)
      case format
      when 'md'
        content = to_markdown
      when 'html'
        content = to_html
      else
        content = to_plaintext
      end

      File.open(dest, 'w') { |file| file.write(content) }
    end


    private


    def read_template(tpl_name)
      File.read(File.expand_path(File.dirname(__FILE__)) + "/tpl/#{tpl_name}.erb")
    end


    def render(template)
      renderer = ERB.new(read_template(template), nil, '>')
      renderer.result(binding)
    end
  end
end