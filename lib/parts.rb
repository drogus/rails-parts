
module Parts
  module DefaultLayout
    def _normalize_options(options)
      if options[:layout].nil? && template_exists?("layouts/#{controller_name}")
        options[:layout] = controller_name
      end

      super(options)
    end
  end

  module Part
    class Base < AbstractController::Base
      attr_accessor :response_body
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
      include AbstractController::Callbacks
      include ::Parts::DefaultLayout

      def initialize(controller, params)
        @controller = controller
        @params = params
      end
    end
  end


  module Helpers
    def part(opts = {})
      klasses, opts = opts.partition do |k,v| 
        k.respond_to?(:ancestors) && k.ancestors.include?(Parts::Part::Base)
      end

      opts = Hash[*(opts.flatten)]

      res = klasses.inject([]) do |memo,(klass,action)|
        memo << klass.new(self, opts).process(action)
      end

      res.size == 1 ? res[0] : res
    end
  end
end


