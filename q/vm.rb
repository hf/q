module Q
  class ParsingException < StandardError
    def initialize input, failure_line, failure_index, failure_reason
      @input = input
      @failure_line = failure_line
      @failure_index = failure_index
      @failure_reason = failure_reason
    end

    def to_s
      @failure_reason
    end

    def reason
      [
        point,
        @failure_reason
      ] * '\n'
    end

    private
    def line
      @failure_line = @input.split('\n')[@failure_line - 1] if @failure_line.kind_of? Fixnum

      @failure_line
    end

    def point
      [
        line,
        " " * (@failure_index + 1) + "^"
      ] * '\n'
    end
  end

  class VM
    def initialize
      @scope  = Q::Scope.new
      @parser = QParser.new
    end

    def eval input
      parsed = @parser.parse input

      if parsed.nil?
        raise ParsingException.new input, @parser.failure_line, @parser.failure_index, @parser.failure_reason
      end

      parsed.eval @scope
    end

    def reset with_scope = false
      @parser = QParser.new
      @scope  = Q::Scope.new if with_scope
    end
  end
end
