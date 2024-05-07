require_relative("../kube")
require_relative("../builder_dsl")

class QueryBuilder
  attr_accessor :query

  include BuilderDSL

  items :client, :namespace, :role
  shorts :resource, :pods, :nodes
  shorts :phase, "Running", "Succeeded", "Failed"
  short :role, :database

  class << self
    def method_missing(...)
      self.new.send(...)
    end
  end

  def initialize
    @query = {}
    @client = Kube.instance.client
    @api = :v1
    @resource = :pods
    @namespace = :developer

    self
  end

  def clear()
    initialize()
  end

  def list
    client_resource.list(**compile_query)
  end

  private

  def compile_query
    selector(:fieldSelector, "status.phase", @phase.to_s) if @phase
    selector(:labelSelector, "role",         @role.to_s)  if @role

    @query
  end

  def selector(group, key, value)
    @query[group] ||= {}
    @query[group][key] = value
  end

  def client_resource
    client
      .api(@api.to_s)
      .resource(@resource.to_s, namespace: @namespace.to_s)
  end
end