desc "Rolls out a release, updating tag and changelog, run to see options"
task :roll => :environment do
  roller = RakeRoll::Roller.new
  puts "----------------------"
  version = RakeRoll::Versioning.new(roller.current_version)
  puts "rake roll options are:"
  puts "----------------------"
  puts "rake roll:pre             #{roller.current_version} => #{version.pre}"
  puts "rake roll:revision        #{roller.current_version} => #{version.revision}"
  puts "rake roll:minor           #{roller.current_version} => #{version.minor}"
  puts "rake roll:major           #{roller.current_version} => #{version.major}"
  puts "rake roll:next            Writes latest commits to changelog without tagging or updating version"
  puts "rake roll:bump            Pass bumped version in eg: BUMP=#{version.revision}"
  puts "----------------------"
  puts "Above will do a dry run, Run with PUSH=true to run for real"
  puts "----------------------"
  puts RakeRoll::Never.new.line
  roller.log_to_s
end

desc "bump the version, update the tag and changelog"
namespace :roll do

  desc "#{RakeRoll::Roller.new.current_version} => #{RakeRoll::Versioning.new(RakeRoll::Roller.new.current_version).revision}"
  task :revision => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if version.current_version
      roller.new_version = version.revision
      do_your_thing(roller, version, "revision")
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

  desc "#{RakeRoll::Roller.new.current_version} => Writes latest commits to changelog without tagging"
  task :next => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if version.current_version
      roller.new_version = version.next
      do_your_thing(roller, version, "next")
    else
      puts "ERROR: Invalid Version Number #{roller.current_version}"
    end
  end

  desc "#{RakeRoll::Roller.new.current_version} => Pass bumped version in eg: BUMP=1.2.3"
  task :bump => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Versioning.new(roller.current_version)
    if new_version = ENV["BUMP"]
      if version.current_version
        roller.new_version = new_version
        do_your_thing(roller, version, "bump")
      else
        puts "ERROR: Invalid Version Number #{roller.current_version}"
      end
    else
      puts "You must supply a version number i.e. BUMP=#{version.revision} rake roll:bump"
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
