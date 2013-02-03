$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "by_navigation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "by_navigation"
  s.version     = ByNavigation::VERSION
  s.authors     = ["Thierry Goettelmann"]
  s.email       = ["byscripts@gmail.com"]
  s.homepage    = "https://github.com/ByScripts/by_navigation"
  s.summary     = "Menu builder gem."
  s.description = "Rails navigation menu builder."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "stringex", "~> 1.5.1"

  s.add_development_dependency "sqlite3"
end
