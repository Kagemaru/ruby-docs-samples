class Kube::Pod < Resource
  attr_reader resource, name, namespace, k8s_resource

  def initialize **kwargs
    @resource = :pod
    @name = kwargs.delete(:name)
    @namespace = kwargs.delete(:namespace)
    @k8s_resource = kwargs.delete(:k8s_resource)
    @rest = kwargs

    if (!@name || !@namespace) && @k8s_resource
      @name ||= @k8s_resource.dig(:metadata, :name)
      @namespace ||= @k8s_resource.dig(:metadata, :namespace)
    end
  end
end
