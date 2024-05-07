require_relative "../utils/kube"

class ReindexSphinx
  def initialize kwargs
    @cluster    = kwargs.fetch :cluster,    "genesis"
    @namespace  = kwargs.fetch :namespace,  "development"
    @deployment = kwargs.fetch :deployment, "vbl-sphinx"
  end

  def run
    pods = running_sphinx_pods
    pod = kube.single_pod pods
    reindex pod
  end

  private

  def reindex pod
    code =
      5.times do |_|
        code = kube.exec @namespace, pod.metadata["name"], "rails ts:index"

        break code if code.zero?

        code
      end
    abort "Five tries and no luck. Giving up. Last exit code: #{code}" unless code.zero?
  end

  def running_sphinx_pods
    kube
      .query
      .namespace(@namespace)
      .role(@deployment)
      .running
      .list
  end

  def kube
    Kube.instance
  end
end
