task :roll => :environment do
  roller = RakeRoll::Roller.new
  version = RakeRoll::Version.new(roller.current_version)
  puts "----------------------"
  puts "rake roll options are:"
  puts "----------------------"
  puts "rake roll:bump            #{roller.current_version} => #{version.bump}"
  puts "rake roll:bump:pre        #{roller.current_version} => #{version.pre}"
  puts "rake roll:bump:minor      #{roller.current_version} => #{version.minor}"
  puts "rake roll:bump:major      #{roller.current_version} => #{version.major}"
  puts "----------------------"
  puts "Above will do a dry run, Run with PUSH=true to run for real"
  roller.log_to_s
end

desc "bump the version, update the tag and changelog"
namespace :roll do

  desc "0.1.0 => 0.1.1"
  task :bump => :environment do
    roller = RakeRoll::Roller.new
    version = RakeRoll::Version.new(roller.current_version)
    roller.new_version = version.bump
    roller.print_versions
    if ENV["PUSH"]
      roller.push
    else
      roller.print_run_for_real_text("bump")
    end
  end

  namespace :bump do

    desc "0.1.0 => 1.0.0"
    task :major => :environment do
      roller = RakeRoll::Roller.new
      version = RakeRoll::Version.new(roller.current_version)
      roller.new_version = version.major
      roller.print_versions
      if ENV["PUSH"]
        roller.push
      else
        roller.print_run_for_real_text("bump:major")
      end
    end

    desc "0.1.0 => 0.2.0"
    task :minor => :environment do
      roller = RakeRoll::Roller.new
      version = RakeRoll::Version.new(roller.current_version)
      roller.new_version = version.minor
      roller.print_versions
      if ENV["PUSH"]
        roller.push
      else
        roller.print_run_for_real_text("bump:minor")
      end
    end

    desc "0.1.0 => 0.1.1a"
    task :pre => :environment do
      roller = RakeRoll::Roller.new
      version = RakeRoll::Version.new(roller.current_version)
      roller.new_version = version.pre
      roller.print_versions
      if ENV["PUSH"]
        roller.push
      else
        roller.print_run_for_real_text("bump:pre")
      end
    end

  end

end

