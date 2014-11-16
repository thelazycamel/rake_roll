module RakeRoll
  class Roller

    attr_reader :current_version, :current_branch
    attr_accessor :new_version

    def initialize
      @current_version = current_version
      @current_branch = current_branch
      @new_version = nil
    end

    def current_version
      @current_version ||= File.read("VERSION").chomp
    end

    def current_branch
      @current_branch ||= `git rev-parse --abbrev-ref HEAD`.chomp
    end

    def new_version
      @new_version ||= current_version.dup.to_s
    end

    def log_to_s
      puts "----------------------"
      puts "CHANGELOG"
      puts parsed_git_log
      if parsed_git_log.empty?
        puts "WARNING: no new CHANGELOG commits added"
      end
      puts "----------------------"
    end

    def print_run_for_real_text(type)
      log_to_s
      puts "=> rake run:#{type} PUSH=true (to run for real)"
      puts "----------------------"
    end

    def print_versions
      puts ""
      puts "----------------------"
      puts "Updating tag from #{current_version} to #{new_version}"
    end

    def parsed_git_log(tag=nil)
      git_log(tag).split("\n").select{|line| line[0] == "*"}.collect do |line|
        line.split(" | ").reverse.join(" | ")
      end
    end

    def push
      puts "Rake Rolling..."
      if parsed_git_log.empty?
        puts "WARNING: no new CHANGELOG commits added"
      end
      update_version
      update_changelog
      commit_changes
      update_tag
      push_tag_and_branch
    end

    private

    def update_version
      puts "updating version to #{new_version}"
      File.open("VERSION", "w") {|f| f.write(new_version) }
    end

    def update_changelog
      puts "updating changelog"
      text = [new_version]
      parsed_git_log.reverse.each do |line|
        text << "\t#{line}"
      end
      original_file = "CHANGELOG"
      new_file = "changelog.tmp"
      File.open(new_file, "w") do |file|
        file.puts text.join("\n")
        File.foreach(original_file) do |line|
          file.puts line
        end
      end
      system("mv changelog.tmp CHANGELOG")
    end

    def commit_changes
      puts "committing changes"
      system('git commit -a -m "Updating Version to #{new_version}"')
    end

    def update_tag
      puts "updating tag to #{new_version}"
      system("git tag #{new_version}")
    end

    def push_tag_and_branch
      puts "pushing tag and branch"
      system("git push origin #{}")
    end

    def format
      "--pretty=format:'%s | %an | %h'"
    end

    def git_log(tag=nil)
      tag ||= current_branch
      `git log #{current_version}..#{tag} #{format}`
    end

  end
end
