module LinuxStat
	module Swap
		class << self
			##
			# List all swap devices and returns a Hash.
			#
			# If the info isn't available, it will return an empty Hash.
			def list
				return {} unless swaps_readable?

				file = IO.readlines('/proc/swaps').drop(1)
				file.reduce({}) do |h, x|
					name, *stats = x.strip.split
					h.merge!(name => stats.map! { |v| v.to_i.to_s == v ? v.to_i : v.to_sym })
				end
			end

			##
			# Returns true if any swap device is available, else returns false.
			#
			# If the info isn't available, it will return an empty Hash.
			def any?
				!!IO.foreach('/proc/swaps').drop(1).first
			end

			# Show aggregated used and available swap.
			#
			# The values are in kilobytes.
			#
			# The return type is Hash.
			# If the info isn't available, the return type is an empty Hash.
			def stat
				return {} unless swaps_readable?
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

			##
			# Shows total amount of swap.
			#
			# The value is in kilobytes.
			#
			# The return type is a Integer but if the info isn't available, it will return nil.
			def total
				return nil unless swaps_readable?
				read_usage[0].sum
			end

			##
			# Show total amount of available swap.
			#
			# The value is in kilobytes.
			#
			# The return type is a Integer but if the info isn't available, it will return nil.
			def available
				return nil unless swaps_readable?
				values_t = read_usage
				values_t[0].sum - values_t[1].sum
			end

			##
			# Show total amount of used swap.
			#
			# The value is in kilobytes.
			#
			# The return type is a Integer but if the info isn't available, it will return nil.
			def used
				return nil unless swaps_readable?
				read_usage[-1].sum
			end

			##
			# Show percentage of swap used.
			#
			# The return type is a Float but if the info isn't available, it will return nil.
			def percent_used
				return nil unless swaps_readable?
				values_t = read_usage

				total = values_t[0].sum
				return 0.0 if total == 0

				values_t[-1].sum.*(100).fdiv(total).round(2)
			end

			##
			# Shows the percentage of swap available.
			#
			# The return type is a Float but if the info isn't available, it will return nil.
			def percent_available
				return nil unless swaps_readable?
				values_t = read_usage

				total = values_t[0].sum
				return 0.0 if total == 0

				total.-(values_t[-1].sum).*(100).fdiv(total).round(2)
			end

			private
			def read_usage
				return [[], []] unless swaps_readable?

				val = IO.readlines('/proc/swaps').drop(1)
				return [[], []] if val.empty?

				val.map { |x|
					x.strip.split.values_at(2, 3).map!(&:to_i)
				}.transpose
			end

			def swaps_readable?
				@@swaps_readable ||= File.readable?('/proc/swaps')
			end
		end
	end
end
