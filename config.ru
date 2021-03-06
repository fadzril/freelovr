# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'rack/sprockets'

# optional - use as necessary
Rack::Sprockets.configure do |config|
  config.cache = true
end

use Rack::Sprockets,
  :load_path => ['app/javascripts', 'app/javascripts/vendor'],
  :hosted_at => '/'

run Freelovr::Application
