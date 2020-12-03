module LinuxStat
	module ProcessInfo
		class << self
			# total_io(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the total read/write caused by a process.
			# The output is Hash. For example, a sample output:
			#    {:read_bytes=>0, :write_bytes=>0}
			#
			# The output is only based on the total disk IO the process has done.
			#
			# If the info isn't available it will return an empty Hash.
			def total_io(pid = $$)
				return {} unless File.readable?("/proc/#{pid}/io".freeze)
				out = {}

				IO.readlines("/proc/#{pid}/io".freeze).each { |x|
					x.strip!

					if x[/^(read|write)_bytes:\s*\d*$/]
						splitted = x.split
						out.merge!(splitted[0].split(?:)[0].to_sym => splitted[-1].to_i)
					end
				}

				out
			end

			# cmdline(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the total command of the process.
			# The output is String. For example, a sample output:
			#    "ruby -r linux_stat -e p LinuxStat::ProcessInfo.cmdline"
			#
			# If the info isn't available it will return an empty frozen String.
			def cmdline(pid = $$)
				file = "/proc/#{pid}/cmdline".freeze
				return ''.freeze unless File.readable?(file)

				_cmdline = IO.read(file)
				_cmdline.gsub!(?\u0000, ?\s)
				_cmdline.tap(&:strip!)
			end

			# command_name(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the total command name of the process.
			# The output is String. For example, a sample output:
			#    "ruby"
			#
			# If the info isn't available it will return an empty frozen String.
			def command_name(pid = $$)
				# Do note that the /proc/ppid/comm may not contain the full name
				file = "/proc/#{pid}/cmdline".freeze
				return ''.freeze unless File.readable?(file)

				_cmdline = IO.read(file)
				_cmdline.gsub!(?\u0000, ?\s)
				File.split(_cmdline.tap(&:strip!).split[0])[-1]
			end

			# mem_stat(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the memory, virtual memory, and resident memory of the process.
			# All values are in Kilobytes.
			#
			# The output is a Hash. For example, a sample output:
			#    {:memory=>8656, :virtual_memory=>78272, :resident_memory=>14072}
			#
			# Note:
			# If you need only memory usage of a process, run LinuxStat::ProcessInfo.memory(pid)
			# If you need only virtual memory for a process, run LinuxStat::ProcessInfo.virtual_memory(pid)
			# If you need only resident memory of a process, run LinuxStat::ProcessInfo.resident_memory(pid)
			#
			# This method opens opens multiple files.
			# But if you need all of the info, then running this method once is efficient.
			#
			# If the info isn't available it will return an empty Hash.
			def mem_stat(pid = $$)
				stat_file = "/proc/#{pid}/stat".freeze
				status_file = "/proc/#{pid}/status".freeze

				stat = if File.readable?(stat_file)
					IO.read(stat_file).split
				else
					[]
				end

				status = if File.readable?(status_file)
					IO.readlines(status_file)
				else
					[]
				end

				_rss_anon = status.find { |x| x.start_with?('RssAnon') }
				rss_anon = _rss_anon ? _rss_anon.split[1].to_i : nil

				_virtual_memory = stat[22]
				vm = _virtual_memory ? _virtual_memory.to_i.fdiv(1024).to_i : nil

				_vm_rss = status.find { |x| x.start_with?('VmRSS') }
				vm_rss = _vm_rss ? _vm_rss.split[1].to_i : nil

				{
					memory: rss_anon,
					virtual_memory: vm,
					resident_memory: vm_rss
				}
			end

			# memory(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the memory of the process.
			# The value is in Kilobytes.
			# The output is an Integer. For example, a sample output:
			#    8664
			#
			# If the info isn't available it will return nil.
			def memory(pid = $$)
				_rss_anon = IO.readlines("/proc/#{pid}/status")
					.find { |x| x.start_with?('RssAnon') }

				_rss_anon ? _rss_anon.split[1].to_i : nil
			end

			# virtual_memory(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the virtual memory for the process.
			# The value is in Kilobytes.
			# The output is an Integer. For example, a sample output:
			#    78376
			#
			# If the info isn't available it will return nil.
			def virtual_memory(pid = $$)
				_virtual_memory = IO.read("/proc/#{pid}/stat".freeze).split[22]
				_virtual_memory ? _virtual_memory.to_i.fdiv(1024).to_i : nil
			end

			# resident_memory(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the resident memory for the process.
			# The value is in Kilobytes.
			# The output is an Integer. For example, a sample output:
			#    14012
			#
			# If the info isn't available it will return nil.
			def resident_memory(pid = $$)
				_vm_rss = IO.readlines("/proc/#{pid}/status")
					.find { |x| x.start_with?('VmRSS') }

				_vm_rss ? _vm_rss.split[1].to_i : nil
			end

			# cpu_stat(pid = $$)
			# Where pid is the process ID and sleep time is the interval between measurements.
			# By default it is the id of the current process ($$), and sleep is 0.05
			#
			# Note 1:
			# Do note that the sleep time can slow down your application.
			# And it's only needed for the cpu usage calculation.
			#
			# It retuns the CPU usage, threads, and the last executed CPU in Hash.
			# For example:
			#    {:cpu_usage=>0.0, :threads=>1, :last_executed_cpu=>1}
			#
			# But if the info isn't available, it will return an empty Hash.
			#
			# The :cpu_usage is in percentage. It's also divided with the number
			# of CPU. :cpu_usage for example, will return 25.0 if the CPU count
			# is 4, and the process is using 100% of a thread / core.
			# A value of 100.0 indicates it is using 100% processing power.
			#
			# The :threads returns the number of threads for the process.
			# The value is a Integer.
			#
			# Note 2:
			# If you just need the CPU usage run LinuxStat::ProcessInfo.cpu_usage(pid = $$)
			# If you just need the threads run LinuxStat::ProcessInfo.threads(pid = $$)
			# If you just need the last executed CPU run LinuxStat::ProcessInfo.last_executed_cpu(pid = $$)
			# Running this method is slower and it opens multiple files at once
			#
			# Only use this method if you need all of the data at once, in such case, it's more efficient to use this method.
			#
			# The :last_executed_cpu also returns an Integer indicating
			# the last executed cpu of the process.
			def cpu_stat(pid = $$, sleep = 0.05)
				file = "/proc/#{pid}/stat"
				return {} unless File.readable?(file)

				ticks = get_ticks

				utime, stime, starttime = IO.read(file)
					.split.values_at(13, 14, 21).map(&:to_f)
				uptime = IO.read('/proc/uptime'.freeze).to_f * ticks

				total_time = utime + stime
				idle1 = uptime - starttime - total_time

				sleep(sleep)
				stat = IO.read(file).split

				utime2, stime2, starttime2 = stat.values_at(13, 14, 21).map(&:to_f)
				uptime = IO.read('/proc/uptime'.freeze).to_f * ticks

				total_time2 = utime2 + stime2
				idle2 = uptime - starttime2 - total_time2

				totald = idle2.+(total_time2).-(idle1 + total_time)
				cpu = totald.-(idle2 - idle1).fdiv(totald).*(100).round(2).abs./(LinuxStat::CPU.count)

				{
					cpu_usage: cpu,
					threads: stat[19].to_i,
					last_executed_cpu: stat[38].to_i
				}
			end

			# cpu_usage(pid = $$, sleep = 0.05)
			# Where pid is the process ID and sleep time is the interval between measurements.
			# By default it is the id of the current process ($$), and sleep is 0.05
			#
			# It retuns the CPU usage in Float.
			# For example:
			#    10.0
			# A value of 100.0 indicates it is using 100% processing power.
			#
			# But if the info isn't available, it will return nil.
			#
			# This method is more efficient than running LinuxStat::ProcessInfo.cpu_stat()
			def cpu_usage(pid = $$, sleep = 0.05)
				file = "/proc/#{pid}/stat"
				return nil unless File.readable?(file)

				ticks = get_ticks

				utime, stime, starttime = IO.read(file)
					.split.values_at(13, 14, 21).map(&:to_f)
				uptime = IO.read('/proc/uptime'.freeze).to_f * ticks

				total_time = utime + stime
				idle1 = uptime - starttime - total_time

				sleep(sleep)

				utime2, stime2, starttime2 = IO.read(file)
					.split.values_at(13, 14, 21).map(&:to_f)
				uptime = IO.read('/proc/uptime'.freeze).to_f * ticks

				total_time2 = utime2 + stime2
				idle2 = uptime - starttime2 - total_time2

				totald = idle2.+(total_time2).-(idle1 + total_time)
				totald.-(idle2 - idle1).fdiv(totald).*(100).round(2).abs./(LinuxStat::CPU.count)
			end

			# threads(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the threads for the current process in Integer.
			# For example:
			#    1
			# But if the info isn't available, it will return nil.
			#
			# This method is way more efficient than running LinuxStat::ProcessInfo.cpu_stat()
			def threads(pid = $$)
				file = "/proc/#{pid}/stat".freeze
				return nil unless File.readable?(file)

				IO.read(file).split[19].to_i
			end

			# last_executed_cpu(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the last executed CPU in Integer.
			# For example:
			#    2
			# But if the info isn't available, it will return nil.
			#
			# This method is way more efficient than running LinuxStat::ProcessInfo.cpu_stat()
			def last_executed_cpu(pid = $$)
				file = "/proc/#{pid}/stat".freeze
				return nil unless File.readable?(file)

				IO.read("/proc/#{pid}/stat".freeze).split[38].to_i
			end

			private
			def get_ticks
				@@ticks ||= Sysconf.sc_clk_tck
			end
		end
	end
end
