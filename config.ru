require './app.rb'

# Rack config
use Rack::Static, :urls => [ '/javascripts', '/style.css', '/favicon.ico', 'custom', '/robots.txt'], :root => 'public'

run WindApp