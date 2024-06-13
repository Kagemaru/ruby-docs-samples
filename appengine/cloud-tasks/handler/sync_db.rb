require "English"
require "pathname"
require "tempfile"
require_relative "../util/kube"

class SyncDB
  def initialize **kwargs
    @source_namespace = kwargs.fetch :source_namespace, "production"
    @target_namespace = kwargs.fetch :target_namespace, "development"
    @stagify = kwargs.fetch :stagify, true
  end

  def run
    validate
    launch_dump_pod
    copy_backup
    shutdown_target_pods
    restore_target_db
    start_target_pods
    stagify_data
  end

  private

  def validate
    case [@source_namespace, @target_namespace]
    in [_, "production"] then abort "No, no no. Not going to touch the production database."
    in [ns, ^ns] then abort "Source and target namespaces must be different."
    end
  end

  def remove_old_dump_pod
    dump_pod.delete if dump_pod
    kube.wait(:delete, dump_pod)
  end

  def launch_dump_pod
    kube.client.create_resource dump_pod
    kube.wait(:running, dump_pod)
  end

  def copy_backup

  end

  def shutdown_target_pods
  end

  def restore_target_db
  end

  def start_target_pods
  end

  def stagify_data
  end

  def dump_pod
    # {namespace: @source_namespace, resource: :pod, resource_name: "jenkins-synchronize-database-dump-provider"}

    @dump_pod ||=
      resource_from_file("sync_db/dump_pod.yaml") do |yaml|
        yaml
          .gsub("SOURCE_NAMESPACE", @source_namespace)
          .gsub("POD_NAME", dump_pod_name)
      end
  end

  def kube
    Kube.instance
  end

  def db_pod
    kube
      .query
      .namespace(@target_namespace)
      .database
      .running
      .single!
      .run
  end

  def resource_from_file file, &block
    yaml = File.read file
    yaml = yield yaml if block

    Tempfile.create "#{@source_namespace}_dump_pod", ".yaml" do |f|
      f.write yaml

      K8s::Resource.from_file f.path
    end
  end
end
