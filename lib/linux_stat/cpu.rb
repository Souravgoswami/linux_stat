module LinuxStat
	module CPU
		class << self
			##
			# = stat(sleep = 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5)
			#
			# Where sleep is the delay to gather the data.
			#
			# The minimum possible value at anytime is 1.0 / LinuxStat::Sysconf.sc_clk_tck
			#
			# This method returns the cpu usage of all threads.
			#
			# The first one is aggregated CPU usage reported by the Linux kernel.
			#
			# And the consecutive ones are the real core usages.
			#
			# On a system with 4 threads, the output will be like::
			#    {0=>84.38, 1=>100.0, 2=>50.0, 3=>87.5, 4=>87.5}
			#
			# If the information is not available, it will return an empty Hash
			def stat(sleep = ticks_to_ms_t5)
				return {} unless stat?

				data = IO.readlines('/proc/stat'.freeze).select { |x| x[/^cpu\d*/] }.map! { |x| x.split.map!(&:to_f) }
				sleep(sleep)
				data2 = IO.readlines('/proc/stat'.freeze).select { |x| x[/^cpu\d*/] }.map! { |x| x.split.map!(&:to_f) }

				# On devices like android, the core count can change anytime (hotplugging).
				# I had crashes on Termux.
				# So better just count the min number of CPU and iterate over that
				# If data.length is smaller than data2.length, we don't have enough data to compare.
				dl, d2l = data.length, data2.length
				min = dl > d2l ? d2l : dl

				min.times.reduce({}) do |h, x|
					user, nice, sys, idle, iowait, irq, softirq, steal = *data[x].drop(1)
					user2, nice2, sys2, idle2, iowait2, irq2, softirq2, steal2 = *data2[x].drop(1)

					idle_then, idle_now  = idle + iowait, idle2 + iowait2
					totald = idle_now.+(user2 + nice2 + sys2 + irq2 + softirq2 + steal2) - idle_then.+(user + nice + sys + irq + softirq + steal)

					res = totald.-(idle_now - idle_then).fdiv(totald).abs.*(100)
					res = res.nan? ? 0.0 : res > 100 ? 100.0 : res

					h.merge!( x => res )
				end
			end

			##
			# = total_usage(sleep = 1.0 / LinuxStat::Sysconf.sc_clk_tck)
			#
			# Where sleep is the delay to gather the data.
			#
			# The minimum possible value at anytime is 1.0 / LinuxStat::Sysconf.sc_clk_tck
			#
			# This method returns the cpu usage of all threads.
			#
			# It's like running LinuxStat::CPU.stat[0] but it's much more efficient and calculates just the aggregated usage which is available at the top of the /proc/stat file.
			#
			# If the information is not available, it will return nil.
			def total_usage(sleep = ticks_to_ms_t5)
				return nil unless stat?

				data = IO.foreach('/proc/stat').first.split.tap(&:shift).map!(&:to_f)
				sleep(sleep)
				data2 = IO.foreach('/proc/stat').first.split.tap(&:shift).map!(&:to_f)

				user, nice, sys, idle, iowait, irq, softirq, steal = *data
				user2, nice2, sys2, idle2, iowait2, irq2, softirq2, steal2 = *data2

				idle_then, idle_now  = idle + iowait, idle2 + iowait2
				totald = idle_now.+(user2 + nice2 + sys2 + irq2 + softirq2 + steal2) - idle_then.+(user + nice + sys + irq + softirq + steal)

				u = totald.-(idle_now - idle_then).fdiv(totald).abs.*(100)
				u > 100 ? 100.0 : u
			end

			##
			# Returns the total number of CPU threads online now.
			#
			# This value can change while a CPU is offline, due to kernel's hotplugging feature.
			#
			# If the information isn't available, it will return 0.
			def online
				# Let's rely on sysconf(_SC_NPROCESSORS_CONF), which is 100x faster than
				# counting online cpu from /sys/devices/system/cpu

				LinuxStat::Sysconf.processor_online
			end

			##
			# Returns the total number of CPU threads configured for the sysetm.
			#
			# If the information isn't available, it will return 0.
			def count
				# Let's rely on sysconf(_SC_NPROCESSORS_ONLN), which is 100x faster than running:
				# IO.read('/sys/devices/system/cpu/online')[-2].to_i + 1

				LinuxStat::Sysconf.processor_configured
			end

			##
			# Returns the model of processor.
			#
			# If the information isn't available, it will return en empty string.
			#
			# The output is also cached (memoized) ; as changing the value in runtime is unexpected.
			def model
				@@name ||= cpuinfo.find { |x| x.start_with?('model name') }.to_s.split(?:)[-1].to_s.strip
			end

			##
			# Returns a Hash with current core frequencies corresponding to the CPUs.
			#
			# For example:
			#    LinuxStat::CPU.cur_freq
			#
			#    => {"cpu0"=>1999990, "cpu1"=>2000042, "cpu2"=>2000016, "cpu3"=>2000088}
			#
			# If the information isn't available, it will return an empty Hash.
			def cur_freq
				@@cur_f ||= cpus.map { |x|
					[File.split(x)[-1], File.join(x, 'cpufreq/scaling_cur_freq'.freeze)]
				}

				h = {}
				@@cur_f.each { |id, file|
					h.merge!(id => IO.read(file).to_i) if File.readable?(file)
				}

				h
			end

			##
			# Returns a Hash with max core frequencies corresponding to the CPUs.
			#
			# For example:
			#    LinuxStat::CPU.min_freq
			#
			#    => {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}
			#
			# If the information isn't available, it will return an empty Hash.
			def min_freq
				@@min_f ||= cpus.map { |x|
					[File.split(x)[-1], File.join(x, 'cpufreq/scaling_min_freq'.freeze)]
				}

				h = {}
				@@min_f.each { |id, file|
					h.merge!(id => IO.read(file).to_i) if File.readable?(file)
				}

				h
			end

			##
			# Returns a Hash with max core frequencies corresponding to the CPUs.
			#
			# For example:
			#    LinuxStat::CPU.max_freq
			#
			#    => {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}
			#
			# If the information isn't available, it will return an empty Hash.
			def max_freq
				@@min_f ||= cpus.map { |x|
					[File.split(x)[-1], File.join(x, 'cpufreq/scaling_max_freq'.freeze)]
				}

				h = {}
				@@min_f.each { |id, file|
					h.merge!(id => IO.read(file).to_i) if File.readable?(file)
				}

				h
			end

			##
			# Returns the corresponding governor of each CPU.
			#
			# The return type is a Hash.
			#
			# For example:
			#    LinuxStat::CPU.governor
			#
			#    => {"cpu0"=>"powersave", "cpu1"=>"powersave", "cpu2"=>"performance", "cpu3"=>"performance"}
			#
			# If the information isn't available, it will return an empty Hash.
			def governor
				@@scaling_g ||= cpus.map { |x|
					[File.split(x)[-1], File.join(x, 'cpufreq/scaling_governor'.freeze)]
				}

				h = {}
				@@scaling_g.each { |id, file|
					h.merge!(id => IO.read(file).tap(&:strip!)) if File.readable?(file)
				}

				h
			end

			##
			# Returns an array of governors for each CPU as a Hash.
			#
			# For example:
			#    LinuxStat::CPU.available_governors
			#
			#    => {"cpu0"=>["performance", "powersave"], "cpu1"=>["performance", "powersave"], "cpu2"=>["performance", "powersave"], "cpu3"=>["performance", "powersave"]}
			#
			# If the information isn't available, it will return an empty Hash.
			def available_governors
				@@scaling_av_g ||= cpus.map { |x|
					[File.split(x)[-1], File.join(x, 'cpufreq/scaling_available_governors'.freeze)]
				}

				h = {}
				@@scaling_av_g.each { |id, file|
					h.merge!(id => IO.read(file).split.each(&:strip!)) if File.readable?(file)
				}

				h
			end

			alias usages stat
			alias usage total_usage

			private
			def cpuinfo
				File.readable?('/proc/cpuinfo') ? IO.readlines('/proc/cpuinfo').freeze : [].freeze
			end

			def stat?
				@@stat_readable ||= File.readable?('/proc/stat')
			end

			# Just to avoid duplicate calculations
			# ticks to ms times 5
			# If the ticks is 100, it will return 0.05
			def ticks_to_ms_t5
				@@ms_t5 ||= 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5
			end

			def cpus
				@@all_cpu = Dir["/sys/devices/system/cpu/cpu[0-9]*/"].sort!.freeze
			end
		end
	end
end
