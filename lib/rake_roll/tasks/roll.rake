desc "Rolls out a release, updating tag and changelog, run to see options"
task :roll => :environment do
  roller = RakeRoll::Roller.new
  puts "----------------------"
  version = RakeRoll::Versioning.new(roller.current_version)
  puts "rake roll options are:"
  puts "----------------------"
  puts "rake roll:bump            #{roller.current_version} => #{version.bump}"
  puts "rake roll:pre             #{roller.current_version} => #{version.pre}"
  puts "rake roll:minor           #{roller.current_version} => #{version.minor}"
  puts "rake roll:major           #{roller.current_version} => #{version.major}"
  puts "rake roll:test            #{roller.current_version} => #{version.test} witout tagging"
  puts "----------------------"
  puts "Above will do a dry run, Run with PUSH=true to run for real"
  puts "----------------------"
  puts RakeRoll::Never.new.line
  roller.log_to_s
end

desc "bump the version, update the tag and changelog"
namespace :roll do

  desc "#{RakeRoll::Roller.new.current_version} => #{RakeRoll::Versioning.new(RakeRoll::Roller.new.current_version).bump}"
  task :bump => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if version.current_version
      roller.new_version = version.bump
      do_your_thing(roller, version, "bump")
    else
      puts "ERROR: Invalid Version Number #{roller.current_version}"
    end
  end

  desc "#{RakeRoll::Roller.new.current_version} => #{RakeRoll::Versioning.new(RakeRoll::Roller.new.current_version).major}"
  task :major => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if version.current_version
      roller.new_version = version.major
      do_your_thing(roller, version, "major")
    else
      puts "ERROR: Invalid Version Number #{roller.current_version}"
    end
  end

  desc "#{RakeRoll::Roller.new.current_version} => #{RakeRoll::Versioning.new(RakeRoll::Roller.new.current_version).minor}"
  task :minor => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if version.current_version
      roller.new_version = version.minor
      do_your_thing(roller, version, "minor")
    else
      puts "ERROR: Invalid Version Number #{roller.current_version}"
    end
  end

  desc "#{RakeRoll::Roller.new.current_version} => #{RakeRoll::Versioning.new(RakeRoll::Roller.new.current_version).pre}"
  task :pre => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if version.current_version
      roller.new_version = version.pre
      do_your_thing(roller, version, "pre")
    else
      puts "ERROR: Invalid Version Number #{roller.current_version}"
    end
  end

  desc "#{RakeRoll::Roller.new.current_version} => #{RakeRoll::Versioning.new(RakeRoll::Roller.new.current_version).test}"
  task :test => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if version.current_version
      roller.new_version = version.test
      do_your_thing(roller, version, "test")
    else
      puts "ERROR: Invalid Version Number #{roller.current_version}"
    end
  end


end

def do_your_thing(roller, version, type)
    roller.print_versions
    if ENV["PUSH"]
      roller.push
    else
      roller.print_run_for_real_text(type)
    end
end
