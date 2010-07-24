
module Parts
  module DefaultLayout
    def _default_layout(require_layout = false)
      layout_name = super

      layout_name || _layout || controller_name
    end
  end

  module Part
    class Base < AbstractController::Base
      attr_reader :params

      def self.controller_name
        @controller_name ||= self.name.demodulize.underscore
      end

      def controller_name
        self.class.controller_name
      end

      include AbstractController::Layouts
      include AbstractController::Translation

      include AbstractController::Helpers
      include AbstractController::Rendering
      include ActionController::ImplicitRender
      include ::Parts::DefaultLayout

      include AbstractController::Callbacks

      def initialize(controller, params)
        @controller = controller
        @params = params
        self.formats = controller.formats
      end
    end
  end


  module Helpers
    def part(opts = {})
      klasses, opts = opts.partition do |k,v| 
        k.respond_to?(:ancestors) && k.ancestors.include?(Parts::Part::Base)
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


