# require_relative "util/kube"
# require_relative "util/kube/builder_dsl"
require_relative "util/kube/query_builder"

def kube
  Kube.instance
end
