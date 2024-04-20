require "English"
require "k8s-ruby"
require "pathname"

class ReindexSphinx
  def initialize kwargs
    @cluster    = kwargs.fetch :cluster,    "genesis"
    @namespace  = kwargs.fetch :namespace,  "development"
    @deployment = kwargs.fetch :deployment, "vbl-sphinx"
  end

  def run
    pods = running_sphinx_pods
    pod = validate pods
    reindex pod
  end

  private

  def reindex pod
    code =
      5.times do |_|
        code = kube_exec pod, "rails ts:index"

        break code if code.zero?

        code
      end
    abort "Five tries and no luck. Giving up. Last exit code: #{code}" unless code.zero?
  end

  def single_pod pods
    case pods.count
    when 0   then abort "No running pods found."
    when 2.. then abort "Too many pods found."
    end

    pods.first
  end

  def running_sphinx_pods
    client
      .api("v1")
      .resource("pods", namespace: @namespace)
      .list(
        labelSelector: { "role" => "vbl-sphinx" },
        fieldSelector: { "status.phase" => "Running" }
      )
  end

  def kube_exec pod, command
    `kubectl exec -it --namespace #{@namespace} #{pod.metadata["name"]} -- bash -c '
    #{command}
    '`

    $CHILD_STATUS.exitstatus
  end

  def client
    @client ||=
      begin
        K8s::Logging.debug!
        K8s::Transport.verbose!

        path = Pathname.new "./kubeconfig.yaml"
        config = K8s::Config.load_file path.expand_path
        K8s::Client.config config
      end
  end
end
