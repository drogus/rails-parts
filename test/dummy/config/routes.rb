Dummy::Application.routes.draw do
  match "/foo" => "main#index", :as => :foo
  # forgive me, it's just for easier testing ;-)
  match "/main/index4.:format" => "main#index4"
  match ':controller(/:action(/:id(.:format)))'
end
