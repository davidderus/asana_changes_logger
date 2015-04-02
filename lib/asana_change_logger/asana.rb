require 'base64'
require 'JSON'
require 'net/https'
require 'date'
require 'cgi'

class Asana

  attr_reader :from, :to

  def initialize(api_key)
    @root = 'https://app.asana.com/api/1.0/'
    @api_key = api_key
  end


  def get_project(project_id)
    puts http_get("projects/#{project_id}")
  end


  def get_project_tasks(project_id, options={})

    default_options = {
      completed_start: 0,
      completed_since: 5,
      completed: true
    }

    options = default_options.merge(options)

    @from = Date.today - options[:completed_start]

    @to = @from - (options[:completed_since] - 1)

    completed_since = @to.to_datetime.strftime("%Y-%m-%dT%H:%M:%S%zZ")
    completed_since = CGI.escape(completed_since)

    tasks = http_get("projects/#{project_id}/tasks?completed_since=#{completed_since}&opt_fields=name,completed,assignee.name,tags.name,completed_at")['data']

    if options[:completed]
      tasks = tasks.select { |task| task['completed'] == true }
    end

    if options[:completed_start] > 0
      tasks = tasks.select { |task| Date.parse(task['completed_at']) <= @from }
    end

    tasks
  end


  def get_remaining_tasks(project_id)
    http_get("projects/#{project_id}/tasks?completed_since=now&opt_fields=name,due_on")['data']
  end


  private


  def http_get(path)
    http, uri, header = http_init(path)

    req = Net::HTTP::Get.new(uri.request_uri, header)
    req.basic_auth(@api_key, '')

    @res = http.start { |http| http.request(req) }

    http_conclude
  end


  def http_init(path)
    uri = URI.parse(@root + path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    header = {
      'Content-Type' => 'application/json'
    }

    return http, uri, header
  end


  def http_conclude
    unless http_ok?
      errors = http_error_msg
      puts "HTTP error : #{errors}"
      exit
    end

    JSON.parse(@res.body)
  end


  def http_ok?
    @res.code == '200'
  end

  def http_error_msg
    body = JSON.parse(@res.body)
    full_errors = []
    body['errors'].each do |error|
      full_errors << error['message']
    end
    full_errors.join(', ')
  end

  class Task
    def initialize(task)
      @task = task
    end


    def get(property)
      res = @task[property]

      if res.is_a?(Hash)
        res = res['name'] ||= res['id']
      elsif res.is_a?(Array)
        res_array = []
        res.each { |tag| res_array << tag['name'] }
        res = res_array.join(', ')
      end

      res
    end


    def to_s
      get('name')
    end
  end
end