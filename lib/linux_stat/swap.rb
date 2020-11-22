module LinuxStat
	module Swap
		class << self
			# List all swap devices
			def list
				file = IO.readlines('/proc/swaps').drop(1)
				file.reduce({}) do |h, x|
					name, *stats = x.strip.split
					h.merge!(name => stats.map! { |v| v.to_i.to_s == v ? v.to_i : v.to_sym })
				end
			end

			# Show aggregated used and available swap
			def stat
				values_t = read_usage

				total, used = values_t[0].sum, values_t[-1].sum
				available = total - used
				percent_used = total == 0 ? 0.0 : used.*(100).fdiv(total).round(2)
				percent_available = total == 0.0 ? 0 : available.*(100).fdiv(total).round(2)

				# We have all the methods, but each methods reads the same file
				{
					total: total,
					used: used,
					available: available,
					percent_used: percent_used,
					percent_available: percent_available
				}
			end

			def total
				read_usage[0].sum
			end

			def available
				values_t = read_usage
				values_t[0].sum - values_t[1].sum
			end

			def used
				read_usage[-1].sum
			end

			def percent_used
				values_t = read_usage

				total = values_t[0].sum
				return 0.0 if total == 0

				values_t[-1].sum.*(100).fdiv(total).round(2)
			end

			def percent_available
				values_t = read_usage

				total = values_t[0].sum
				return 0.0 if total == 0

				total.-(values_t[-1].sum).*(100).fdiv(total).round(2)

			end

			private
			def read_usage
				return [[], []] unless swaps_readable?

				IO.readlines('/proc/swaps').drop(1).map { |x|
					x.strip.split.values_at(2, 3).map!(&:to_i)
				}.transpose
			end

			def swaps_readable?
				@@swaps_readable ||= File.readable?('/proc/swaps')
			end
		end
	end
end
