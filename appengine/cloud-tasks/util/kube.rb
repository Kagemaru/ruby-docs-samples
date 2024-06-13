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

  def delete resource, name, config: nil
    ctl "delete #{resource}/#{name}", config
  end

  ## /Commands }}}
  ## Checks {{{

  def wait **kwargs
    config = config_from kwargs

    condition =
      case kwargs[:condition]
      in :delete | nil then "delete"
      in :running then "jsonpath='{.status.phase}'=Running"
      else kwargs[:condition]
      end
        .then { |c| "--for=#{c}" }

    timeout = "--timeout=#{kwargs[:timeout]}" if kwargs[:timeout]
    id = "#{config.resource}/#{config.resource_name}"

    command = ["wait", condition, timeout, id].compact.join " "

    ctl command, config
  end

  ## /Checks }}}
  # /Kubectl wrappers }}}
  # Selectors {{{

  def query
    @query ||= QueryBuilder.new
  end

  # /Selectors }}}

  private

  # Helpers {{{

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
      pod_name ||= pod.dig(:metadata, :name)
    else
      pod = nil
    end

    Kube::Settings.new(namespace: namespace, pod_name: pod_name, pod: pod, **kwargs)
  end

  # Helpers }}}

  class Pod
  end
end
