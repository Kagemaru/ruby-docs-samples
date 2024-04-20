require "sinatra"
require "json"
require_relative "handler/reindex_sphinx"

$stdout.sync = true

get "/" do
  "Hello World!"
end

post "/reindex_sphinx" do
  # We expect a json payload in the request body.
  data = JSON.parse request.body.read rescue {}

  puts "Received reindex_sphinx task, running it now"
  ReindexSphinx.new(data).run
  puts "Done running the reindex sphinx task"
  "Done running the reindex sphinx task"
end
