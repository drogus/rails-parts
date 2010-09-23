require "parts"
require 'rails'
begin
  require "abstract_controller/railties/routes_helpers"
rescue LoadError
  # not on edge :(
end

module Parts
  class Railtie < Rails::Railtie
    initializer "parts.include_helpers" do |app|
      ActiveSupport.on_load(:action_controller) do
        ActionView::Base.send(:include, Parts::Helpers)
        ActionController::Base.send(:include, Parts::Helpers)
        ActionController::Base.helper_method(:part)
      end

      ActiveSupport.on_load(:parts) do
        if app.routes.respond_to?(:mounted_helpers)
          include app.routes.mounted_helpers
          extend ::AbstractController::Railties::RoutesHelpers.with(app.routes)
        else
          include app.routes.url_helpers
        end
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
      Parts::Base.config[:assets_dir] = ActionController::Base.config.assets_dir
    end
  end
end
