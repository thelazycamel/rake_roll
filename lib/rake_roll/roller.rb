module RakeRoll
  class Roller

    include GitCommands

    attr_reader :current_version, :current_branch
    attr_accessor :new_version

    def initialize
      @current_version = current_version
      @current_branch = current_branch
      @new_version = nil
    end

    def current_version
      return @current_version if @current_version
      if File.exist?("VERSION")
        File.read("VERSION").chomp
      else
        build_version
      end
    end

    def current_branch
      @current_branch ||= get_current_branch
    end

    def new_version
      @new_version ||= current_version.dup.to_s
    end

    def log_to_s
      puts "----------------------"
      puts "CHANGELOG"
      puts parsed_git_log
      puts "WARNING: no new CHANGELOG commits added" if parsed_git_log.empty?
      puts "----------------------"
    end

    def print_run_for_real_text(type)
      log_to_s
      puts "To run for real:"
      if type == "bump"
        puts "$> BUMP=#{new_version} PUSH=true rake roll:#{type}"
      else
        puts "$> PUSH=true rake roll:#{type}"
      end
      puts "----------------------"
    end

    def print_versions
      puts ""
      puts "----------------------"
      puts "Updating tag from #{current_version} to #{new_version}"
    end

    def parsed_git_log(tag=nil)
      tag ||= current_branch
      log_type = "#{current_version}..#{tag} --pretty=format:'%s'"
      git_log(log_type).split("\n").select{|line| line[0] == "*"}
    end

    def push
      puts "Rake Rolling..."
      puts "WARNING: no new CHANGELOG commits added" if parsed_git_log.empty?
      update_version_file unless next_version?
      clean_changelog_next
      update_changelog
      git_commit("Updating Version to #{new_version}")
      git_tag(new_version) unless next_version?
      git_push_branch(@current_branch)
      git_push_tags unless next_version?
      puts RakeRoll::Never.new.line
    end

    private

    def update_version_file
      puts "updating version to #{new_version}"
      File.open("VERSION", "w") {|f| f.write(new_version) }
    end

    def update_changelog
      puts "updating changelog"
      version_and_date = "#{new_version} (#{Time.now.strftime("%d-%b-%y")})"
      text = [version_and_date]
      parsed_git_log.reverse.each do |line|
        text << "\t#{line}"
      end
      original_file = "CHANGELOG"
      new_file = "changelog.tmp"
      #add the new version and commits
      File.open(new_file, "w") do |file|
        file.puts text.join("\n")
        #add drop in the old version and commits underneath
        File.foreach(original_file) do |line|
          file.puts line
        end
      end
      system("mv changelog.tmp CHANGELOG")
    end

    def build_version
      File.open("VERSION", "w") {|f| f.write("0.0.1") }
      File.open("CHANGELOG", "w") {|f| f.write("0.0.1") } unless File.exist?("CHANGELOG")
      git_add("VERSION")
      git_add("CHANGELOG")
      git_commit("Creating Version and Changelog version 0.0.1")
      git_tag("0.0.1")
    end

    def next_version?
      new_version == test_version
    end

    def test_version
      RakeRoll::Versioning.new(current_version).next
    end

    def clean_changelog_next
      puts "cleaning changelog"
      original_file = "CHANGELOG"
      new_file = "changelog.tmp"
      File.open(new_file, "w") do |file|
        in_next = false
        File.foreach(original_file) do |line|
          in_next = true if line.start_with?(test_version)
          in_next = false if line.start_with?(current_version)
          file.puts line unless in_next
        end
      end
      system("mv changelog.tmp CHANGELOG")
    end
  end
end
