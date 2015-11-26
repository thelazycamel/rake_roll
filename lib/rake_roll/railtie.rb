require 'rails'

module RakeRoll

  class Railtie < Rails::Railtie
    railtie_name :rake_roll

    rake_tasks do
      import File.join(File.dirname(__FILE__), "rake_roll/tasks/roll.rake")
    end
  end

end
