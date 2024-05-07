module BuilderDSL
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def items(*args)
      args.each { |method| item(method) }
    end

    def item(method)
      define_item(method)
    end

    def shorts(to, *args)
      args.each do |arg|
        case arg
        in [from, value]
        in value then from = methodize(value)
        end

        short(to, from, value) 
      end
    end

    def short(*args)
      case args
      in [to, from, value]
      in [to, value] then from = methodize(value)
      end

      define_item(to) unless respond_to?(to)
      define_short(to, from, value)
    end

    def define_item(method)
      define_method(method) do |*args, **kwargs|
        value = kwargs[:value] || args.first

        if value
          instance_variable_set("@#{method}", value)
          self
        else
          instance_variable_get("@#{method}")
        end
      end
    end

    def define_short(to, from, value)
      define_method(from) { send(to, value) }
    end

    def methodize(name)
      name
        .to_s
        .downcase
        .gsub(/[^a-zA-Z0-9_]/, '_')
        .to_sym
    end
  end
end