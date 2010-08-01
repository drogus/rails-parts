Gem::Specification.new do |s|
  s.name        = "rails-parts"
  s.version     = "0.3.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Piotr Sarnacki"]
  s.email       = ["drogus@gmail.com"]
  s.homepage    = "http://github.com/drogus/rails-parts"
  s.summary     = "Merb parts ported to rails"
  s.description = "This gem allows you to use parts in your rails app"

  s.required_rubygems_version = ">= 1.3.6"

  s.files        = Dir.glob("lib/**/*") + %w(MIT-LICENSE README.rdoc Rakefile Gemfile)
  s.require_path = 'lib'

  s.add_runtime_dependency("rails", [">= 3.0.0.beta4"])
end
