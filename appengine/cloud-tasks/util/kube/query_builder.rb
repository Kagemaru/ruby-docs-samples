require_relative("../kube")
require_relative("../builder_dsl")

class QueryBuilder
  attr_accessor :query

  include BuilderDSL

  # Setup {{{
  class << self
    def respond_to_missing?(...)
      new.respond_to?(...)
    end

    def method_missing(...)
      new.send(...)
    end
  end

  def initialize
    @query = RecursiveOpenStruct.new
    @match = RecursiveOpenStruct.new
    @client = Kube.instance.client
    @api = :v1
    @resource = :pods
    @namespace = :developer
  end

  # /Setup }}}
  # Actions {{{

  def run
    compile_query
    run_query
    filter list
  end

  def clear
    initialize
  end

  # /Actions }}}
  # Query {{{

  ## Connection Details {{{

  items :client, :namespace
  shortcuts :resource, :pods, :nodes

  ## /Connection Details }}}
  ## Filters {{{

  shortcuts :phase, "Running", "Succeeded", "Failed"
  shortcuts :role, :database

  def match(keys, arguments, method: nil)
    @match[keys][:args] = arguments
    @match[keys][:method] = method if method
  end

  ## /Filters }}}
  ## Results {{{

  shortcuts :limit_amount, :all, :first, :single!, :none!, default: :all

  ## /Results }}}

  # /Query }}}

  private

  # Helpers {{{

  def run_query
    query[:fieldSelector]["status.phase"] = @phase.to_s if @phase
    query[:labelSelector]["role"] = @role.to_s if @role

    client_resource.list(**query.to_h)
  end

  def client_resource
    client
      .apis(prefetch_resources: true)
      .api(@api.to_s)
      .resource(@resource.to_s, namespace: @namespace.to_s)
  end

  def filter(list)
    list
      .select { |l| matching(l) }
      .then { |l| restrict_amount l }
  end

  def matching(item, method: :match?)
    @match.to_h.all? do |keys, pattern|
      keys = [keys].flatten

      value = item.dig(*keys)

      value.send(method, pattern)
    end
  end

  def restrict_amount list
    limit =
      case limit_amount
      in 0 then :none!
      in 1 then :single!
      else limit_amount
      end

    count = list.length

    case [count, limit]
    # Success cases
    in [_, :all] then list
    in [x, ^x] then list
    in [_, :first] then list.first
    in [1, :single!] then list.first
    in [0, :none!] then true

    # Failure cases
    in [0, _] then raise "No #{resource} was found."
    in [_, 0] then raise "A #{resource} was found."
    in [x, y] then raise "#{y} #{resource} requested, #{x} found."
    end
  end

  # /Helpers }}}
end
