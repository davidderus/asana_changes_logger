require 'base64'
require 'JSON'
require 'net/https'
require 'date'
require 'cgi'

require 'asana_change_logger/export'

class Asana
  def initialize(api_key)
    @root = 'https://app.asana.com/api/1.0/'
    @api_key = api_key
  end


  def get_project(project_id)
    puts http_get("projects/#{project_id}")
  end


  def get_project_tasks(project_id, completed_since = nil, completed = true)
    completed_since = Date.today - completed_since
    completed_since = completed_since.to_datetime.strftime("%Y-%m-%dT%H:%M:%S%zZ")
    completed_since = CGI.escape(completed_since)

    tasks = http_get("projects/#{project_id}/tasks?completed_since=#{completed_since}&opt_fields=name,completed,assignee.name,tags.name")['data']

    if completed
      tasks = tasks.select { |task| task['completed'] == true }
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
      raise "HTTP error : #{errors}"
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
end