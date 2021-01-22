module LinuxStat
	# Shows various Memory related information of the current system.

	module Memory
		class << self
			##
			# Returns the memory details reported by /proc/meminfo. In this format:
			#    {:total=>3836264, :used=>3097952, :available=>738312, :percent_used=>80.75, :percent_available=>19.25}
			#
			# The values are in Kilobyte.
			#
			# If the statistics is not available, it will return an empty Hash.
			def stat
				return {} unless meminfo?

				memory = IO.foreach('/proc/meminfo'.freeze).first(3)

				total = memory[0].split[1].to_i
				available = memory[2].split[1].to_i
				used = total - available

				percent_used = total == 0 ? 0.0 : used.*(100).fdiv(total).round(2)
				percent_available = total == 0 ? 0.0 : available.*(100).fdiv(total).round(2)

				# We have all the methods, but each methods reads the same file
				#
				# So better to use the above calculation
				{
					total: total,
					used: used,
					available: available,
					percent_used: percent_used,
					percent_available: percent_available
				}
			end

			##
			# Returns the total memory reported by LS::Sysinfo.totalram()
			# The value is in Kilobyte.
			#
			# It retuns an Integer but if the info is not available, it will return nil.
			def total
				v = LinuxStat::Sysinfo.totalram
				v ? v.fdiv(1024).to_i : nil
			end

			##
			# Returns the free memory reported by LS::Sysinfo.freeram()
			# The value is in Kilobyte.
			#
			# It retuns an Integer but if the info is not available, it will return nil.
			def free
				v = LinuxStat::Sysinfo.freeram
				v ? v.fdiv(1024).to_i : nil
			end

			##
			# Returns the total memory details reported by /proc/meminfo.
			# The value is in Kilobyte.
			#
			# It retuns an Integer but if the info is not available, it will return nil
			def available
				return nil unless meminfo?
				IO.foreach('/proc/meminfo'.freeze).first(3)[-1].split[1].to_i
			end

			##
			# Returns the amount of memory used reported by /proc/meminfo.
			# The value is in Kilobyte.
			#
			# It retuns an Integer but if the info is not available, it will return nil.
			def used
				return nil unless meminfo?
				memory = IO.foreach('/proc/meminfo'.freeze).first(3)
				memory[0].split[1].to_i - memory[2].split[1].to_i
			end

			##
			# Returns the percentage of memory used reported by /proc/meminfo.
			#
			# It retuns an Integer but if the info is not available, it will return nil
			def percent_used
				return nil unless meminfo?
				memory = IO.foreach('/proc/meminfo'.freeze).first(3)
				total = memory[0].split[1].to_i
				total.-(memory[2].split[1].to_i).*(100).fdiv(total).round(2)
			end

			##
			# Returns the percentage of memory used reported by /proc/meminfo.
			#
			# It retuns an Integer but if the info is not available,  it will return nil
			def percent_available
				return nil unless meminfo?
				memory = IO.foreach('/proc/meminfo'.freeze).first(3)
				memory[2].split[1].to_i.*(100).fdiv(memory[0].split[1].to_i).round(2)
			end

			private
			def meminfo?
				@@readable ||= File.readable?('/proc/meminfo'.freeze)
			end
		end
	end
end
