require './q/vm'

module Q
  def self.load debug = false
    if debug
      return Treetop.load 'q'
    end

    return require './q/parser'
  end
end
