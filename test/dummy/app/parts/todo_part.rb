class TodoPart < Parts::Base
  before_filter :load_todos

  def list
  end

  def one
    render :list, :layout => false
  end

  def load_todos
    @todos = ["Do this", "Do that", 'Do the other thing']
  end

  def formatted_output
  end

  def part_with_params
  end

  def with_custom_layout
    render :list, :layout => "foo"
  end

  def with_helpers
    render :layout => false
  end

  def use_params
    render :inline => "<%= params[:omg] %>"
  end

  def part_renders_part
    render :layout => false
  end
end
