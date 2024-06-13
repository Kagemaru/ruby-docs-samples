require "sinatra"
require "json"
require_relative "util/utils"

$stdout.sync = true

get("/") { "Hello World!" }

handler_endpoints = [:reindex_sphinx, :sync_db]

handler_endpoints.each do |endpoint|
  require_relative "handler/#{endpoint}"

  post "/#{endpoint}" do
    # We expect a json payload in the request body.
    data = begin
      JSON.parse request.body.read
    rescue
      {}
    end

    puts "Received #{endpoint} task, running it now"

    Utils.constantize(endpoint).new(data).run

    puts "Done running the #{endpoint} task"
    "Done running the #{endpoint} task"
  end
end
