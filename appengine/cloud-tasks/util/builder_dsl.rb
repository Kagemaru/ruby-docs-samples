module BuilderDSL
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # Item methods {{{

    def items(*args, **kwargs)
      args.each { |method| item(method, **kwargs) }
    end

    def item(method, **)
      define_item(method, **)
    end

    def define_item(method, **kwargs)
      instance_variable_set(:"@#{method}", kwargs[:default])

      define_method(method) do |*args|
        value = args.first

        if value
          instance_variable_set(:"@#{method}", value)
          self
        else
          instance_variable_get(:"@#{method}") || default
        end
      end
    end

    # /Item methods }}}
    # Shortcut methods {{{

    def shortcuts(to, *args, **kwargs)
      args.each do |arg|
        case arg
        in [from, value]
        in value then from = methodize(value)
        end

        shortcut(to, from, value, **kwargs)
      end
    end

    def shortcut(*args, **)
      case args
      in [to, from, value]
      in [to, value] then from = methodize(value)
      end

      define_item(to, **) unless respond_to?(to)
      define_shortcut(to, from, value)
    end

    def define_shortcut(to, from, value)
      define_method(from) { send(to, value) }
    end

    # /Shortcut methods }}}
    # Helpers {{{

    def methodize(name)
      name
        .to_s
        .downcase
        .gsub(/[^a-zA-Z0-9_]/, "_")
        .to_sym
    end

    # /Helpers }}}
  end
end
