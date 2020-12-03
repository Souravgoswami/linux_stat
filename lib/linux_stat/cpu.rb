module LinuxStat
	module CPU
		class << self
			# stat(sleep = 0.075)
			# Where sleep is the delay to gather the data.
			# This method returns the cpu usage of all threads.
			#
			# The first one is aggregated CPU usage reported by the Linux kernel.
			# And the consecutive ones are the real core usages.
			#
			# On a system with 4 threads, the output will be like::
			# {0=>84.38, 1=>100.0, 2=>50.0, 3=>87.5, 4=>87.5}
			#
			# If the information is not available, it will return an empty Hash
			def stat(sleep = 0.075)
				return {} unless stat?

				data = IO.readlines('/proc/stat').select! { |x| x[/^cpu\d*/] }.map! { |x| x.split.map!(&:to_f) }
				sleep(sleep)
				data2 = IO.readlines('/proc/stat').select! { |x| x[/^cpu\d*/] }.map! { |x| x.split.map!(&:to_f) }

				data.size.times.reduce({}) do |h, x|
					user, nice, sys, idle, iowait, irq, softirq, steal = *data[x].drop(1)
					user2, nice2, sys2, idle2, iowait2, irq2, softirq2, steal2 = *data2[x].drop(1)

					idle_then, idle_now  = idle + iowait, idle2 + iowait2
					totald = idle_now.+(user2 + nice2 + sys2 + irq2 + softirq2 + steal2) - idle_then.+(user + nice + sys + irq + softirq + steal)

					h.merge!(
						x => totald.-(idle_now - idle_then).fdiv(totald).*(100).round(2).abs
					)
				end
			end

			# total_usage(sleep = 0.075)
			# Where sleep is the delay to gather the data.
			# This method returns the cpu usage of all threads.
			#
			# It's like running LinuxStat::CPU.stat[0] but it's much more efficient and calculates just the aggregated usage which is available at the top of the /proc/stat file.
			#
			# If the information is not available, it will return nil.
			def total_usage(sleep = 0.075)
				return nil unless stat?

				data = IO.foreach('/proc/stat').first.split.tap(&:shift).map!(&:to_f)
				sleep(sleep)
				data2 = IO.foreach('/proc/stat').first.split.tap(&:shift).map!(&:to_f)

				user, nice, sys, idle, iowait, irq, softirq, steal = *data
				user2, nice2, sys2, idle2, iowait2, irq2, softirq2, steal2 = *data2

				idle_then, idle_now  = idle + iowait, idle2 + iowait2
				totald = idle_now.+(user2 + nice2 + sys2 + irq2 + softirq2 + steal2) - idle_then.+(user + nice + sys + irq + softirq + steal)
				totald.-(idle_now - idle_then).fdiv(totald).*(100).round(2).abs
			end

			# Returns the total number of CPU threads.
			# If the information isn't available, it will return 0.
			def count
				# CPU count can change during the program runtime
				cpuinfo.count { |x| x.start_with?('processor') }
			end

			# Returns the model of processor.
			# If the information isn't available, it will return en empty string.
			#
			# The output is also cached (memoized) ; as changing the value in runtime is unexpected.
			def model
				@@name ||= cpuinfo.find { |x| x.start_with?('model name') }.to_s.split(?:)[-1].to_s.strip
			end

			# Returns an array with current core frequencies corresponding to the usages.
			# If the information isn't available, it will return an empty array.
			def cur_freq
				@@cpu_freqs ||= Dir["/sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq"]
				@@cur_freqs_readable ||= @@cpu_freqs.all?(&File.method(:readable?))

				if @@cur_freqs_readable
					@@cpu_freqs.map { |x| IO.read(x).to_i }
				else
					[]
				end
			end

			# Returns an array with max core frequencies corresponding to the usages.
			# If the information isn't available, it will return an empty array.
			def max_freq
				@@max_freqs ||= Dir["/sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_max_freq"]
				@@max_freqs_readable ||= @@max_freqs.all?(&File.method(:readable?))

				if @@max_freqs_readable
					@@max_freqs.map { |x| IO.read(x).to_i }
				else
					[]
				end
			end

			alias usages stat
			alias usage total_usage

			private
			def cpuinfo
				File.readable?('/proc/cpuinfo') ? IO.readlines('/proc/cpuinfo') : []
			end

			def stat?
				@@stat_readable ||= File.readable?('/proc/stat')
			end
		end
	end
end
