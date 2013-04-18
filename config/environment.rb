# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Wmapps::Application.initialize!

# set time zone to be EST
config.time_zone = 'Eastern Time (US & Canada)'
