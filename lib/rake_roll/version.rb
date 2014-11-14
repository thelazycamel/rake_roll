module RakeRoll

  class Version

    attr_reader :current_version

    def initialize(current_version)
      @current_version = current_version
    end

    def bump
      nums = @current_version.split(".")
      last_number = nums[-1].scan(/\d/).first.to_i
      last_number = last_number + 1
      nums[-1] = last_number
      nums.join(".")
    end

    def pre
      nums = @current_version.split(".")
      pre_letter = nums[-1].scan(/\D/).first
      if pre_letter
        next_letter = pre_letter.next
        nums[-1].gsub!(pre_letter, next_letter)
      else
        nums[-1] = nums[-1] + "a"
      end
      nums.join(".")
    end

    def minor
      nums = @current_version.split(".")
      minor_number = nums[1].scan(/\d/).first.to_i
      minor_number = minor_number + 1
      nums[1] = minor_number.to_s
      nums.last.gsub!(/\D/, "")
      nums[-1] = "0" if nums.length == 3
      nums.join(".")
    end

    def major
      nums = @current_version.split(".")
      major_number = nums[0].scan(/\d/).first.to_i
      major_number = major_number + 1
      nums[0] = major_number
      nums[-1] = "0"
      if nums.length == 3
        nums[-2] = "0"
      end
      nums.join(".")
    end

  end

end
