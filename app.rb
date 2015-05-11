require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')

get("/") do
  @tasks = Task.all()
   erb(:index)
end

get("/lists/new") do
  erb(:list_form)
end

post("/lists/new") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  erb(:index)
end

post("/tasks") do
  description = params.fetch("description")
  task = Task.new({:description => description, :done => false})
  task.save()
  @tasks = Task.all()
  erb(:list_form)
end


get("/lists") do
  @lists = List.all()
  erb(:lists)
end

# get("/tasks") do
#   @tasks = Task.all()
#   erb(:index)
# end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end
