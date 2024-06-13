class Utils
  class << self
    # File activesupport/lib/active_support/inflector/methods.rb, line 70
    def camelize(term, uppercase_first_letter = true)
      string = term.to_s
      # String#camelize takes a symbol (:upper or :lower), so here we also support :lower to keep the methods consistent.
      if !uppercase_first_letter || uppercase_first_letter == :lower
        string = string.sub(inflections.acronyms_camelize_regex) { |match| match.downcase! || match }
      elsif string.match?(/\A[a-z\d]*\z/)
        return inflections.acronyms[string]&.dup || string.capitalize
      else
        string = string.sub(/^[a-z\d]*/) { |match| inflections.acronyms[match] || match.capitalize! || match }
      end
      string.gsub!(/(?:_|(\/))([a-z\d]*)/i) do
        word = $2
        substituted = inflections.acronyms[word] || word.capitalize! || word
        $1 ? "::#{substituted}" : substituted
      end
      string
    end


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
