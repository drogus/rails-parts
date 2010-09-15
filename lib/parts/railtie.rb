require "parts"
require 'rails'

module Parts
  class Railtie < Rails::Railtie
    initializer "parts.include_helpers" do |app|
      ActiveSupport.on_load(:action_controller) do
        ActionView::Base.send(:include, Parts::Helpers)
        ActionController::Base.send(:include, Parts::Helpers)
        ActionController::Base.helper_method(:part)
      end
    end

    initializer "parts.set_paths" do |app|
      paths = app.config.paths
      paths.app.parts 'app/parts', :eager_load => true
      paths.app.parts.views 'app/parts/views'

      paths.app.parts.views.to_a.each do |path|
        Parts::Base.append_view_path path
      end

      Parts::Base.helpers_path = paths.app.helpers.to_a.first
    end
  end
end
