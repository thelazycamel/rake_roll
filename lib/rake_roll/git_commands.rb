module RakeRoll

  module GitCommands

    def get_current_branch
      `git rev-parse --abbrev-ref HEAD`.chomp
    end

    def git_push_branch(branch)
      puts "Pushing to origin #{branch}"
      system("git push origin #{branch}")
    end

    def git_push_tags
      puts "Pushing tags"
      system("git push --tags")
    end

    def git_log(log_type)
      system("git log #{log_type}")
    end

    def git_add(file)
      puts "Adding #{file}"
      system("git add #{file}")
    end

    def git_tag(tag)
      puts "Creating tag #{new_version}"
      system("git tag #{tag}")
    end

    def git_commit(message)
      puts "Commiting: #{message}"
      system("git commit -a -m '#{message}'")
    end

  end
end
