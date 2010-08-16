class <%= class_name %>Part < Parts::Base
<% actions.each do |action| -%>
  def <%= action %>
  end

<% end -%>
end
