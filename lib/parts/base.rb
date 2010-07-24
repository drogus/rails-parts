require 'parts/default_layout'

module Parts
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
    include DefaultLayout

    include AbstractController::Callbacks

    def initialize(controller, params)
      @controller = controller
      @params = params
      self.formats = controller.formats
    end
  end
end
