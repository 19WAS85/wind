require 'sequel'
require 'sequel/extensions/pagination'

Dir['plugins/*.rb'].each { |plugin| require plugin }  

# Database connection.
DB = Sequel.connect 'sqlite://wind.db'

# Sequel schema plugin.
Sequel::Model.plugin :schema

# Database models.
Dir['models/*.rb'].each { |model| require model }

# Sinatra configurations.
configure do
  enable :sessions
end

# Application helpers.
helpers do
  require 'helpers'
end

# Blog configurations.
$settings = Setting.from_database

# Posts per page
PAGE_SIZE = 10

at_start_execution