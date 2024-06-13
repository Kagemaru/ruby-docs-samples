require "google/cloud/tasks"

class CloudTask
  class << self
    def create
      parent = parent client

      puts "Sending task #{task}"
      response = client.create_task parent: parent, task: task

      puts "Created task #{response.name}" if response.name
    end

    private

    def task method: "POST", uri: "/reindex_sphinx", payload: "{}", seconds: 120
      timestamp = Google::Protobuf::Timestamp.new
      timestamp.seconds = Time.now.to_i + seconds.to_i

      {
        app_engine_http_request: {
          http_method: method,
          relative_uri: uri,
          body: payload
        },
        schedule_time: timestamp
      }
    end

    def parent client, project: nil, location: nil, queue: nil
      @parent ||=
        client.queue_path(
          project: project || ENV["GOOGLE_CLOUD_PROJECT_ID"],
          location: location || ENV["LOCATION_ID"],
          queue: queue || ENV["QUEUE_ID"]
        )
    end

    def client
      @client ||= Google::Cloud::Tasks.cloud_tasks
    end
  end
end

CloudTask.create
