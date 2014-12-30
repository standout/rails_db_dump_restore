$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_db_dump_restore/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_db_dump_restore"
  s.version     = RailsDbDumpRestore::VERSION
  s.authors     = ["Albert Arvidsson"]
  s.email       = ["albert.arvidsson@gmail.com"]
  s.homepage    = "http://github.com/standout/rails_db_dump_restore"
  s.summary     = "Add rake db:dump, rake db:restore and cap db:pull"
  s.description = "Add rake db:dump, rake db:restore and cap db:pull"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0"
  s.add_dependency "activerecord"
end
