module Parts
  module Helpers
    def part(opts = {})
      klasses, opts = opts.partition do |k,v| 
        k.respond_to?(:ancestors) && k.ancestors.include?(Parts::Base)
      end

      opts = opts.inject({}) {|h,v| h[v.first] = v.last; h}

      res = klasses.inject([]) do |memo,(klass,action)|
        part = klass.new(self, opts)
        part.process(action)
        memo << part.response_body
      end

      res.size == 1 ? res[0] : res
    end
  end
end
