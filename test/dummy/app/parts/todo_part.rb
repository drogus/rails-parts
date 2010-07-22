class TodoPart < Parts::Part::Base
  before_filter :load_todos

  def list
    render :list, :layout => "todo_part"
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

  def parth_with_absolute_template
    render :template => File.expand_path(self._template_root) / 'todo_part' / 'formatted_output'
  end
end
