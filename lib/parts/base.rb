require 'parts/default_layout'

module Parts
  class Base < AbstractController::Base
    attr_reader :params, :controller

    include AbstractController::Layouts
    include AbstractController::Translation
    include ActionController::Helpers
    include AbstractController::Rendering
    include ActionController::ImplicitRender
    include DefaultLayout
    include AbstractController::Callbacks

    def initialize(controller, params)
      @controller = controller
      @params = controller.params.dup
      @params.merge!(params) unless params.empty?
      self.formats = controller.formats
    end

    delegate  :protect_against_forgery?, :session, :verified_request?, :form_authenticity_param,
              :request_forgery_protection_token, :form_authenticity_token, :to => :controller
    helper_method :protect_against_forgery?, :session,
                  :request_forgery_protection_token, :form_authenticity_token

    def self.inherited(klass)
      super
      klass.helper :all
    end

    ActiveSupport.run_load_hooks(:parts, self)
  end
end
