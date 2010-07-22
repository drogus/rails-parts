
class MainController < ActionController::Base
  def index
    render :text => part(TodoPart => :list)
  end

  def index2
    render :text => (part TodoPart => :one)
  end

  def index3
    res = part(TodoPart => :one) + part(TodoPart => :list)
    render :text => res
  end

  def index4
     render :text => part(TodoPart => :formatted_output)
  end

  def part_with_params
    res = part(TodoPart => :part_with_params, :my_param => "my_value", :my_second_param => "my_value")
    render :text => res
  end

  def part_with_arrays_in_params
    res = part(TodoPart => :part_with_params, :my_param => ['my_first_value', 'my_second_value'], :my_second_param => "my_value")
    render :text => res
  end

  def part_within_view
  end

  def parth_with_absolute_template
    res = part(TodoPart => :parth_with_absolute_template)
    render :text => res
  end

end
