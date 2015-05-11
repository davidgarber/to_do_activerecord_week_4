ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require("sinatra/activerecord")
require("task")
require('pry')
require('./lib/list')
require('./lib/task')

RSpec.configure do |config|
  config.after(:each) do
    Task.all().each() do |task|
      task.destroy()
    end
  end
end
