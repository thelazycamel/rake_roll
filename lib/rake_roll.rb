require "rake"
require "rake_roll/version"
require "rake_roll/versioning"
require "rake_roll/never"
require "rake_roll/git_commands"
require "rake_roll/roller"
import File.join(File.dirname(__FILE__), "rake_roll/tasks/roll.rake")

module RakeRoll
  require 'rake_roll/railtie' if defined?(Rails)
end
