$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cadinsor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cadinsor"
  s.version     = Cadinsor::VERSION
  s.authors     = ["lewstherin"]
  s.email       = ["r@lewstherin.com"]
  s.homepage    = "www.lewstherin.com"
  s.summary     = "Provide OAuth2 like authentication for your APIs"
  s.description = "Cadinsor provides OAuth like authentication to validate requests from your client apps to your backend Rails application."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
