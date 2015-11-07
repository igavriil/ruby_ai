$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
Coveralls.wear!

require 'ruby_ai'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
