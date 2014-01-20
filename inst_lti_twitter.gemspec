$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "inst_lti_twitter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lti_twitter_engine"
  s.version     = InstLtiTwitter::VERSION
  s.authors     = ["Eric Berry", "Brad Humphrey"]
  s.email       = ["ericb@instructure.com", "brad@insructure.com"]
  s.homepage    = "https://github.com/instructure/inst-lti-twitter"
  s.summary     = "LTI App for Twitter"
  s.description = "Embed a Twitter widget into your LMS with this LTI App."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "twitter", "~> 5.0.0.rc.1"
  s.add_dependency "ims-lti", "~> 1.1.4"

  s.add_development_dependency "sqlite3" # needed to run tests
end
