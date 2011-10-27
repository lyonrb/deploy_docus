ENV["RACK_ENV"] ||= 'test'

gem 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require 'mocha'

$:<< 'lib'
require 'deploy_docus'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
