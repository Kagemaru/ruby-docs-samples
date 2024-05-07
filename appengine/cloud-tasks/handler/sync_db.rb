require "English"
require "pathname"
require_relative "../utils/kube"

class SyncDB
  def initialize kwargs
    @source_namespace = kwargs.fetch :source_namespace, "production"
    @target_namespace = kwargs.fetch :target_namespace, "development"
    @stagify          = kwargs.fetch :stagify,          true
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
    in [ns, ns]          then abort "Source and target namespaces must be different."
    end
  end

  def launch_dump_pod
    yaml = YAML
    .load_file("sync_db/dump_pod.yaml")
    .gsub(/SOURCE_NAMESPACE/, @source_namespace)
    .gsub(/POD_NAME/, dump_pod_name)

    kube.ctl 
  end

  def copy_backup
  end

  def shutdown_target_pods
  end

  def restore_target_db
    pod = db_pod @target_namespace
  end

  def start_target_pods
  end

  def stagify_data
  end

  def dump_pod_name
    "jenkins-synchronize-database-dump-provider"
  end

  def kube
    Kube.instance
  end

  def db_pod namespace
    pods =
      kube
      .query
      .namespace(namespace)
      .database
      .running
      .list

    kube.single_pod pods
  end
end
