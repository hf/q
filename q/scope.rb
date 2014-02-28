module Q
  class Scope
    def initialize parents = nil
      @map = {}
      @args = []
      @parents = [ parents ].flatten.compact
      @this = nil
    end

    def [] name
      return @map[name] if has_own? name

      @parents.each do |parent|
        if parent.has? name
          return parent[name]
        end
      end

      return nil
    end

    def []= name, value
      return @map[name] = value if has_own? name

      @parents.each do |parent|
        if parent.has? name
          return parent[name] = value
        end
      end

      @map[name] = value
    end

    def has? name
      if has_own? name
        return true
      end

      @parents.each do |parent|
        if parent.has? name
          return true
        end
      end

      return false
    end

    def has_own? name
      @map.has_key? name
    end

    def args= args
      @args = [args].flatten
    end

    def args
      @args
    end

    def this= th
      if has_own? '@'
        return @map['@'] = @this = th
      end

      @this = th
    end

    def this
      if has_own? '@'
        return @this = @map['@']
      end

      @this
    end

    def inspect
      str = "Q::Scope --\n"

      @map.each do |key, value|
        str += "  #{key} => #{value}\n"
      end

      if not @parents.empty?
        str += "\n  parents:\n"

        @parents.each do |parent|
          str += "  #{parent.inspect}\n"
        end
      end

      str
    end
  end
end
