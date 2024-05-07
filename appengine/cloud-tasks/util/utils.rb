class Utils
  class << self
    def constantize name
      const_name =
        name
        .to_s
        .split(/[^a-zA-Z0-9]/)
        .map(&:capitalize)
        .join

      Kernel.const_get const_name
    end
  end
end
