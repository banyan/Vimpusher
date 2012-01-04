require 'json'
require 'resque'

# Load redis settings
path = '/home/dotcloud/environment.json'
dotcloud_env = JSON.parse(File.read(path)) if File.exists?(path)
Resque.redis = dotcloud_env['DOTCLOUD_REDIS_REDIS_URL'] || 'localhost:6379' unless dotcloud_env.nil?

# Load the rails application
require File.expand_path('../application', __FILE__)

# # Initialize the rails application
Vimpusher::Application.initialize!
