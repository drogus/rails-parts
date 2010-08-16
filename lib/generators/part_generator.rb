require 'rails/generators/base'
require 'rails/generators/named_base'

class PartGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  
  argument :actions, :type => :array, :default => [], :banner => "action action"
  check_class_collision :suffix => "Part"
  
  def generate_part_class
    template "part.rb", "app/parts/#{file_name}_part.rb"
  end
  
  def create_part_views
    inside("app/parts/views/#{file_name}_part") do
      actions.each do |action|
        create_file "#{action}.html.erb"
      end
    end
  end
end