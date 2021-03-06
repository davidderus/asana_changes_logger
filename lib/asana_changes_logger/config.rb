require 'yaml/store'

class Config
  def initialize
    params_dir = File.join(Dir.home, '.asana_changes_logger/')
    unless Dir.exist?(params_dir)
      Dir.mkdir(params_dir)
    end
    @store = YAML::Store.new params_dir + 'config.yml'
  end


  def auth?
    auth_error unless @store.transaction { @store.fetch(:key, false) }
  end


  def auth_error
    puts "Error: Make sure to use the -a argument to set you're Asana API key in order to start."
    exit
  end


  def set_api_key(key)
    @store.transaction { @store[:key] = key }
  end


  def get_api_key
    @store.transaction { @store[:key] }
  end
end