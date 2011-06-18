require 'sequel'
require 'sequel/extensions/pagination'
require 'yaml'

require './lib/atstart.rb'
require './lib/datasync.rb'
require './lib/extend_string.rb'

# Load config from YAML file
config = YAML.load_file("./config/config.yml")

# Plugins.
Dir['plugins/*.rb'].each { |plugin| require plugin }  

# Database connection.
DB = Sequel.connect config["database"]

# Sequel schema plugin.
Sequel::Model.plugin :schema

# Database models.
Dir['models/*.rb'].each { |model| require "./#{model}" }

# Application helpers.
helpers do
  require './helpers'
end

# Blog configurations.
$settings = Setting.from_database

# Posts per page
PAGE_SIZE = config["posts_per_page"]

at_start_execution