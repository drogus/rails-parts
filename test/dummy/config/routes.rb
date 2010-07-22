Dummy::Application.routes.draw do
  # forgive me, it's just for easier testing ;-)
  match ':controller(/:action(/:id(.:format)))'
end
