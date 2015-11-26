require "rake"
require "rake_roll/version"
require "rake_roll/versioning"
require "rake_roll/never"
require "rake_roll/git_commands"
require "rake_roll/roller"
if defined?(Rails)
  require 'rake_roll/railtie'
else
  import File.join(File.dirname(__FILE__), "rake_roll/tasks/roll.rake")
end

module RakeRoll
end
