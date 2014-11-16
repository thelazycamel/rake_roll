module RakeRoll

  class Version

    attr_reader :current_version

    def initialize(current_version)
      @current_version = current_version
    end

    def bump
      if nums = check_and_split_current_version
        last_number = nums[-1].scan(/\d/).first.to_i
        last_number = last_number + 1
        nums[-1] = last_number
        nums.join(".")
      end
    end

    def pre
      if nums = check_and_split_current_version
        pre_letter = nums[-1].scan(/\D/).first
        if pre_letter
          next_letter = pre_letter.next
          nums[-1].gsub!(pre_letter, next_letter)
        else
          nums[-1] = nums[-1] + "a"
        end
        nums.join(".")
      end
    end

    def minor
      if nums = check_and_split_current_version
        minor_number = nums[1].scan(/\d/).first.to_i
        minor_number = minor_number + 1
        nums[1] = minor_number.to_s
        nums.last.gsub!(/\D/, "")
        nums[-1] = "0" if nums.length == 3
        nums.join(".")
      end
    end

    def major
      if nums = check_and_split_current_version
        major_number = nums[0].scan(/\d/).first.to_i
        major_number = major_number + 1
        nums[0] = major_number
        nums[-1] = "0"
        nums[-2] = "0" if nums.length == 3
        nums.join(".")
      end
    end

    private

    def check_and_split_current_version
      splits = @current_version.split(".")
      return false if splits.size < 2 || splits.size > 3
      splits
    end

  end

end
