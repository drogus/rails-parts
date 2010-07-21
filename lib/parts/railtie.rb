require "parts"
require 'rails'

module Parts
  class Railtie < Rails::Railtie
    initializer "parts.include_helpers" do |app|
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send(:include, Parts::Helpers)
        ActionController::Base.helper_method(:part)
      end
    end
  end
end
