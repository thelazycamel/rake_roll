require 'rails'

module RakeRoll

  class Railtie < Rails::Railtie
    railtie_name :rake_roll

    rake_tasks do
      import File.join(File.dirname(__FILE__), "tasks/roll.rake")
    end
  end

end
