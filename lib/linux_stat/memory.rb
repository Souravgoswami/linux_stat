module LinuxStat
	module Memory
		class << self
			def stat
				return {} unless meminfo?

				memory = IO.foreach('/proc/meminfo').first(3)

				total = memory[0].split[1].to_i
				available = memory[2].split[1].to_i
				used = total - available

				percent_used = total == 0 ? 0.0 : used.*(100).fdiv(total).round(2)
				percent_available = total == 0 ? 0.0 : available.*(100).fdiv(total).round(2)

				# We have all the methods, but each methods reads the same file
				# So better to use the above calculation
				{
					total: total,
					used: used,
					available: available,
					percent_used: percent_used,
					percent_available: percent_available
				}
			end

			def total
				return 0 unless meminfo?
				IO.foreach('/proc/meminfo').first.split[1].to_i
			end

			def available
				return 0 unless meminfo?
				IO.foreach('/proc/meminfo').first(3)[-1].split[1].to_i
			end

			def used
				return 0 unless meminfo?
				memory = IO.foreach('/proc/meminfo').first(3)
				memory[0].split[1].to_i - memory[2].split[1].to_i
			end

			def percent_used
				return 0.0 unless meminfo?
				memory = IO.foreach('/proc/meminfo').first(3)
				total = memory[0].split[1].to_i
				total.-(memory[2].split[1].to_i).*(100).fdiv(total).round(2)
			end

			def percent_available
				return 0.0 unless meminfo?
				memory = IO.foreach('/proc/meminfo').first(3)
				memory[2].split[1].to_i.*(100).fdiv(memory[0].split[1].to_i).round(2)
			end

			private
			def meminfo?
				@@readable ||= File.readable?('/proc/meminfo')
			end
		end
	end
end
