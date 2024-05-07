require "English"
require "k8s-ruby"
require "singleton"
require "pathname"
require_relative "kube/query_builder"

class Kube
  include Singleton

  Settings = Struct.new(:namespace, :pod_name, :pod)
  
  # Setup {{{

  def initialize
    K8s::Logging.debug!
    K8s::Transport.verbose!
  end

  def client path: nil
    @client ||= K8s::Client.config kubeconfig(path)
  end

  # /Setup }}}
  # Kubectl wrappers {{{
  ## Commands {{{

  def ctl command, **kwargs
    config = config_from kwargs

    `kubectl --namespace #{config.namespace} #{command}`

    $CHILD_STATUS.exitstatus
  end

  def exec command, **kwargs
    config = config_from kwargs

    ctl config.namespace, "exec -it #{config.pod} -- bash -c '
    #{command}
    '"

    $CHILD_STATUS.exitstatus
  end

  ## /Commands }}}
  ## Waiting {{{
  
  def wait_for for="delete", timeout=60, **kwargs
    config = config_from(kwargs)

    ctl "wait --for=#{for} pod/#{config.pod_name} --timeout=#{timeout}s", config
  end

  ## /Waiting }}}
  # /Kubectl wrappers }}}
  # Selectors {{{

  def query
    @query ||= QueryBuilder.new
  end

  def single_pod! pods
    case pods.count
    when 0   then raise "No running pods found."
    when 2.. then raise "Too many pods found."
    end

    pods.first
  end

  def single_pod pods
    single_pod! pods
  rescue RuntimeError => e
    e.message
  end

  # /Selectors }}}

  private

  def kubeconfig path
    path ||= ENV["KUBECONFIG"]
    path ||= "./kubeconfig.yaml"

    path = Pathname.new(path).expand_path
    K8s::Config.load_file path
  end

  def config_from(kwargs)
    return kwargs if kwargs.is_a?(Kube::Settings)

    case kwargs
    in { pod_name:, namespace: } if pod_name.is_a?(String) && namespace.is_a?(String)
    in { pod_name: } if pod_name.to_s.include?("/")
      namespace, pod_name = pod_name.split "/"
    in { pod_name: } if [String, Symbol].include?(pod_name.class)
    else
      namespace = pod_name = nil
    end

    case kwargs
    in { pod: } if pod.is_a?(K8s::Resource) && pod.kind == "Pod"
      namespace ||= pod.to_hash.dig(:metadata, :namespace)
      pod_name  ||= pod.dig(:metadata, :name)
    else
      pod = nil
    end

    Kube::Settings.new(namespace: namespace, pod_name: pod_name, pod: pod)
  end
end