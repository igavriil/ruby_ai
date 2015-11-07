$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
Coveralls.wear!

require 'ruby_ai'
require 'ruby_ai/search/core/frontier'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
