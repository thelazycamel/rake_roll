task :roll => :environment do
  puts VERSION
end

desc "bump the version, update the tag and changelog"
namespace :roll do

  desc "0.1.0 => 0.1.1"
  task :bump => :environment do
    current = VERSION.to_version
    current.bump!
    puts "#{VERSION} => #{current}"
  end

  namespace :bump do

    desc "0.1.0 => 1.0.0"
    task :major => :environment do
      current = VERSION.to_version
      current.bump! :major
      puts "#{VERSION} => #{current}"
    end

    desc "0.1.0 => 0.2.0"
    task :minor => :environment do
      current = VERSION.to_version
      current.bump! :minor
      puts "#{VERSION} => #{current}"
    end

    desc "0.1.0 => 0.1.1a"
    task :pre => :environment do
      current = VERSION.to_version
      current.bump! :pre
      puts "#{VERSION} => #{current}"
    end

  end

end

