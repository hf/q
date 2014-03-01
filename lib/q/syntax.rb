require 'treetop'

module Q
  module Syntax

    class Function < Treetop::Runtime::SyntaxNode
      def eval prefscope
        defargs = args

        prefscope['_'] = this = lambda { |scope|
            argscope = Q::Scope.new

            defargs.each_with_index do |arg, i|
              argscope[arg] = scope.args[i]
            end

            fscope = Q::Scope.new [argscope, scope, prefscope]
            fscope.this = this

            fscope['_'] = statements.eval fscope

            return fscope.this
          }
      end

      def args
        arguments.elements.map do |argument|
          argument.identifier.text_value
        end
      end
    end

    class Conditional < Treetop::Runtime::SyntaxNode
      def eval scope
        if condition.eval(scope) == true
          return consequence.eval(scope)
        end

        if has_otherwise?
          return otherwise.consequence.eval(scope)
        end

        false
      end

      def has_otherwise?
        not otherwise.elements.nil?
      end
    end
  end
end
