module LinuxStat
	# Shows various CPU related information of the current system.

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
			# For example, on a system with 4 threads:
			#    LinuxStat::CPU.stat
			#
			#    => {0=>84.38, 1=>100.0, 2=>50.0, 3=>87.5, 4=>87.5}
			#
			# It discards any offline CPU or disabled CPU.
			# For example, if your system CPU has 4 cores, and you disabled core 3, the output will be:
			#    LinuxStat::CPU.stat
			#
			#    => {0=>26.67, 1=>0.0, 2=>20.0, 4=>20.0}
			#
			# If the information is not available, it will return an empty Hash
			def stat(sleep = ticks_to_ms_t5)
				return {} unless stat?

				data = IO.readlines('/proc/stat'.freeze).select { |x| x[/^cpu\d*/] }
				cpu_names1 = []
				data.map! { |x|
					splitted = x.split
					name = splitted.shift[/\d*$/]
					cpu_names1.push(name.empty? ? 0 : name.to_i + 1)
					splitted.map!(&:to_f)
				}

				sleep(sleep)
				data2 = IO.readlines('/proc/stat'.freeze).select { |x| x[/^cpu\d*/] }

				cpu_names2 = []
				data2.map! { |x|
					splitted = x.split
					name = splitted.shift[/\d*$/]
					cpu_names2.push(name.empty? ? 0 : name.to_i + 1)
					splitted.map!(&:to_f)
				}

				# On devices like android, the core count can change anytime (hotplugging).
				# I had crashes on Termux.
				# So better just count the min number of CPU and iterate over that
				# If data.length is smaller than data2.length, we don't have enough data to compare.
				dl, d2l = cpu_names1.length, cpu_names2.length
				if dl > d2l
					min = d2l
					cpu_cores = cpu_names2
				else
					min = dl
					cpu_cores = cpu_names1
				end

				min.times.reduce({}) do |h, x|
					cpu_core = cpu_cores[x]
					user, nice, sys, idle, iowait, irq, softirq, steal = *data[x]
					user2, nice2, sys2, idle2, iowait2, irq2, softirq2, steal2 = *data2[x]

					idle_then, idle_now  = idle + iowait, idle2 + iowait2
					totald = idle_now.+(user2 + nice2 + sys2 + irq2 + softirq2 + steal2) - idle_then.+(user + nice + sys + irq + softirq + steal)

					res = totald.-(idle_now - idle_then).fdiv(totald).abs.*(100)
					res = res.nan? ? 0.0 : res > 100 ? 100.0 : res.round(2)

					h.store(cpu_core, res)
					h
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

				data = IO.foreach('/proc/stat'.freeze).first.split.tap(&:shift).map!(&:to_f)
				sleep(sleep)
				data2 = IO.foreach('/proc/stat'.freeze).first.split.tap(&:shift).map!(&:to_f)

				user, nice, sys, idle, iowait, irq, softirq, steal = *data
				user2, nice2, sys2, idle2, iowait2, irq2, softirq2, steal2 = *data2

				idle_then, idle_now  = idle + iowait, idle2 + iowait2
				totald = idle_now.+(user2 + nice2 + sys2 + irq2 + softirq2 + steal2) - idle_then.+(user + nice + sys + irq + softirq + steal)

				u = totald.-(idle_now - idle_then).fdiv(totald).abs.*(100)
				u > 100 ? 100.0 : u.round(2)
			end

			##
			# Returns the total number of CPU available for the sysetm.
			#
			# It returns an Integer.
			#
			# If the information isn't available, it will return nil.
			def count
				@@cpu_count ||= LinuxStat::Sysconf.processor_configured
			end

			##
			# Returns the total number of CPU online in the sysetm.
			#
			# It first reads /proc/stat, if that fails, it will
			# read /sys/devices/system/cpu/online,
			# if that fails it will open /proc/cpuinfo.
			# If neither of the procedures work, it will get the
			# LinuxStat::Sysconf.processor_online
			#
			# It opens /sys/devices/system/cpu/offline and
			# performs various job to get one Ruby array.
			#
			# If the information isn't available, it will return an empty Array.
			def count_online
				@@cpuinfo_file ||= '/proc/cpuinfo'.freeze
				@@cpuinfo_readable ||= File.readable?(@@cpuinfo_file)

				@@stat_file ||= '/proc/stat'.freeze

				# Not much slow, not blazing fast, somewhat reliable
				get_online = online

				if !get_online.empty?
					get_online.length
				elsif @@cpuinfo_readable
					# Way slower but reliable!
					IO.readlines(@@cpuinfo_file).count { |x| x.strip[/\Aprocessor.*\d*\z/] }
				else
					# Way faster but absolutely unrealiable!
					LinuxStat::Sysconf.processor_online
				end
			end

			##
			# Returns the total number of CPU online in the sysetm.
			#
			# It will read /proc/stat to get the info.
			#
			# If the info isn't available, it reads /sys/devices/system/cpu/onfline and
			# performs various job to get one Ruby array.
			#
			# If the information isn't available, it will return an empty Array.
			def online
				@@online_file ||= '/sys/devices/system/cpu/online'.freeze
				@@online_readable ||= File.readable?(@@online_file)

				@@stat_file ||= '/proc/stat'.freeze

				ret = []

				if stat?
					IO.readlines(@@stat_file).map { |x|
						v = x.strip[/\Acpu\d*/] &.[](/\d/)
						ret << v.to_i if v
					}
				elsif @@online_readable
					IO.read(@@online_file).split(?,.freeze).each { |x|
						x.strip!
						c = x.split(?-.freeze).map(&:to_i)
						ret.concat(c.length == 2 ? Range.new(*c).to_a : c)
					}
				end

				ret
			end

			##
			# Returns the total number of CPU offline in the sysetm.
			#
			# It opens /sys/devices/system/cpu/offline and
			# performs various job to get one Ruby array.
			#
			# If the information isn't available, it will return an empty Array.
			def offline
				@@offline_file ||= '/sys/devices/system/cpu/offline'.freeze
				@@offline_readable ||= File.readable?(@@offline_file)
				return [] unless @@offline_readable

				ret = []
				IO.read(@@offline_file).split(?,.freeze).each { |x|
					x.strip!
					c = x.split(?-.freeze).map(&:to_i)
					ret.concat(c.length == 2 ? Range.new(*c).to_a : c)
				}

				ret
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
					h.store(id, IO.read(file).to_i) if File.readable?(file)
				}

				h
			end

			def times
				LinuxStat::ProcFS.cpu_times
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
					h.store(id, IO.read(file).to_i) if File.readable?(file)
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
					h.store(id, IO.read(file).to_i) if File.readable?(file)
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
					h.store(id, IO.read(file).tap(&:strip!)) if File.readable?(file)
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
					h.store(id, IO.read(file).split.each(&:strip!)) if File.readable?(file)
				}

				h
			end

			##
			# Returns the number of physical cores on the system.
			#
			# The return value is an Array of Integers. Each number denoting the physical processor number.
			# You can later use this to schedule tasks or something else (not provided by LinuxStat).
			#
			# However, if the information isn't available on /sys/devices/system/cpu[0-9]*/topology/thread_siblings_list, it will return an empty Array.
			def physical_core_list
				physical_cores = []
				hyperthreaded = {}

				return [] unless File.executable?('/sys/devices/system/cpu/'.freeze)
				entries = Dir.entries('/sys/devices/system/cpu/'.freeze)
				entries.delete(?..freeze)
				entries.delete('..'.freeze)

				entries.each do |x|
					if x[0..2] == 'cpu'.freeze && LinuxStat::Misc.integer?(x[3..-1])
						file = "/sys/devices/system/cpu/#{x}/topology/thread_siblings_list"
						next unless File.readable?(file)

						data = IO.read(file)
						data.strip!

						val = data.split(?,.freeze).map(&:to_i)
						val.shift

						# Add items has for fast lookup.
						# This hash includes all hyper threaded cores that doesn't map to anything.
						# But this hash has the purpose to look up for items and not include in the list of physical_cores
						# This is just an array, but can look for keys in O(1), so it's faster than ary.find() { ... }.
						val.each { |x| hyperthreaded.store(x, nil) }

						key = x[3..-1].to_i
						physical_cores << key unless hyperthreaded.key?(key)
					end
				end

				physical_cores
			end

			##
			# Returns the number of physical cores on the system.
			#
			# The return value is an Array of Integers. Each number denoting the hyperthreaded processor number.
			# You can later use this to schedule tasks or something else (not provided by LinuxStat).
			#
			# However, if the information isn't available on /sys/devices/system/cpu[0-9]*/topology/thread_siblings_list, it will return an empty Array.
			def hyperthreaded_core_list
				hyperthreaded = {}

				return [] unless File.executable?('/sys/devices/system/cpu/'.freeze)
				entries = Dir.entries('/sys/devices/system/cpu/'.freeze)
				entries.delete(?..freeze)
				entries.delete('..'.freeze)

				entries.each do |x|
					if x[0..2] == 'cpu'.freeze && LinuxStat::Misc.integer?(x[3..-1])
						file = "/sys/devices/system/cpu/#{x}/topology/thread_siblings_list"
						next unless File.readable?(file)

						data = IO.read(file)
						data.strip!

						val = data.split(?,.freeze).map(&:to_i)
						val.shift

						# Add items has for fast lookup to get rid of duplicate items.
						val.each { |x| hyperthreaded.store(x, nil) unless hyperthreaded.key?(x) }
					end
				end

				hyperthreaded.keys
			end

			alias usages stat
			alias usage total_usage
			alias physical_cores physical_core_list
			alias hyperthreaded_cores hyperthreaded_core_list

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
				@@sc_clk_tck ||= LinuxStat::Sysconf.sc_clk_tck.to_i
				@@ms_t5 ||= 1.0 / (@@sc_clk_tck < 1 ? 100 : @@sc_clk_tck) * 5
			end

			def cpus
				@@all_cpu = Dir["/sys/devices/system/cpu/cpu[0-9]*/"].sort!.freeze
			end
		end
	end
end
