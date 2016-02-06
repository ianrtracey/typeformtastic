$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "typeformtastic/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "typeformtastic"
  s.version     = Typeformtastic::VERSION
  s.authors     = ["Ian Tracey"]
  s.email       = ["ianrtracey@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Typeformtastic."
  s.description = "TODO: Description of Typeformtastic."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end
