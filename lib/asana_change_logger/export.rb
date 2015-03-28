module AsanaChangeLogger
  class Exporter
    def initialize(tasks)
      @list_tasks = tasks
      @as_tasks = []
      objectify
    end


    def objectify
      @list_tasks.each { |task| @as_tasks << Asana::Task.new(task) }
    end


    def ready?
      @as_tasks && @as_tasks.length > 0
    end


    def to_markdown
      raise 'Not ready' unless ready?
      @as_tasks.join('\r\n')
    end


    def to_html
      raise 'Not ready' unless ready?
      @as_tasks.join('\r\n')
    end


    def to_pdf
      raise 'Not ready' unless ready?
      @as_tasks.join('\r\n')
    end


    def to_term
      raise 'Not ready' unless ready?
      puts @as_tasks
    end


    def save(dest, format)
      case format
      when 'pdf'
        content = to_pdf
      when 'html'
        content = to_html
      else
        content = to_markdown
      end

      File.open(dest, 'w') { |file| file.write(content) }
    end
  end
end