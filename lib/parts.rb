module Parts
  module Part
    class Base < AbstractController::Base
      attr_accessor :response_body
      attr_reader :action_name, :params

      def self.controller_path; "app/parts/" end
      def controller_path; self.class.name.underscore end

      include AbstractController::Layouts
      include AbstractController::Translation

      include AbstractController::Helpers
      include AbstractController::Rendering

      def initialize(controller)
        @controller = controller

        # initialize from mixins takes 0 arguments
        super()
      end

      def process_action(method_name, *args)
        @params = args.extract_options!
        send_action(method_name)
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
        memo << klass.new(self).process(action, opts)
      end

      res.size == 1 ? res[0] : res
    end
  end
end


