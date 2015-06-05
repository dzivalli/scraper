$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scraper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scraper"
  s.version     = Scraper::VERSION
  s.authors     = ["Stas"]
  s.email       = ["stas@rostio.ru"]
  s.homepage    = ""
  s.summary     = "Summary of Scraper."
  s.description = "Description of Scraper."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rspec"
end
