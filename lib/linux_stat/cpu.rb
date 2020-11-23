module LinuxStat
	module CPU
		class << self
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

			def total_usage(sleep = 0.075)
				return {} unless stat?

				data = IO.foreach('/proc/stat').first.split.tap(&:shift).map!(&:to_f)
				sleep(sleep)
				data2 = IO.foreach('/proc/stat').first.split.tap(&:shift).map!(&:to_f)

				user, nice, sys, idle, iowait, irq, softirq, steal = *data
				user2, nice2, sys2, idle2, iowait2, irq2, softirq2, steal2 = *data2

				idle_then, idle_now  = idle + iowait, idle2 + iowait2
				totald = idle_now.+(user2 + nice2 + sys2 + irq2 + softirq2 + steal2) - idle_then.+(user + nice + sys + irq + softirq + steal)
				totald.-(idle_now - idle_then).fdiv(totald).*(100).round(2).abs
			end

			def count
				# CPU count can change during the program runtime
				cpuinfo.count { |x| x.start_with?('processor') }
			end

			def model
				# Cached ; as changing the value in runtime is unexpected ; nobody is going
				# to add/remove CPUs during program runtime
				@@name ||= cpuinfo.find { |x| x.start_with?('model name') }.to_s.split(?:)[-1].to_s.strip
			end

			# Returns an array with current core frequencies corresponding to the usages
			def cur_freq
				# Cached ; as changing the value in runtime is unexpected ; nobody is going
				# to add/remove CPUs during program runtime

				@@cpu_freqs ||= Dir["/sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq"]
				@@cpu_freqs.map { |x| IO.read(x).to_i }
			end

			# Returns an array with max core frequencies corresponding to the usages
			def max_freq
				# Cached ; as changing the value in runtime is unexpected ; nobody is going
				# to add/remove CPUs during program runtime

				@@max_freqs ||= Dir["/sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_max_freq"]
				@@max_freqs.map { |x| IO.read(x).to_i }
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
