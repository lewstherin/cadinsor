$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cadinsor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cadinsor"
  s.version     = Cadinsor::VERSION
  s.authors     = ["lewstherin"]
  s.email       = ["r@lewstherin.com"]
  s.homepage    = "http://github.com/lewstherin/cadinsor"
  s.summary     = "Provide OAuth2 like authentication for your API calls from client applications"
  s.description = "Cadinsor provides OAuth like authentication to validate requests from your client apps to your backend Rails application."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "rabl", "~> 0.9"
  s.add_development_dependency "sqlite3", "~> 1.3"
  s.license = "MIT"
end
