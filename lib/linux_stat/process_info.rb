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
			# All values are in kilobytes.
			#
			# The output is a Hash. For example, a sample output:
			#    {:memory=>8515.584, :virtual_memory=>79781.888, :resident_memory=>13955.072}
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
				statm = "/proc/#{pid}/statm".freeze

				data = if File.readable?(statm)
					IO.read(statm).split
				else
					return {}
				end

				_rss_anon = (data[1] && data[2]) ? data[1].to_i.-(data[2].to_i).*(pagesize).fdiv(1000) : nil
				_virtual_memory = data[0] ? data[0].to_i*(pagesize).fdiv(1000) : nil
				_resident_memory = data[1] ? data[1].to_i.*(pagesize).fdiv(1000) : nil

				{
					memory: _rss_anon,
					virtual_memory: _virtual_memory,
					resident_memory: _resident_memory
				}
			end

			# memory(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the memory of the process.
			# The value is in kilobytes.
			# The output is an Integer. For example, a sample output:
			#    8523.776
			#
			# If the info isn't available it will return nil.
			def memory(pid = $$)
				file = "/proc/#{pid}/statm".freeze
				return nil unless File.readable?(file)

				data = IO.read(file).split
				(data[1] && data[2]) ? data[1].to_i.-(data[2].to_i).*(pagesize).fdiv(1000) : nil
			end

			# virtual_memory(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the virtual memory for the process.
			# The value is in kilobytes.
			# The output is an Integer. For example, a sample output:
			#    79781.888
			#
			# If the info isn't available it will return nil.
			def virtual_memory(pid = $$)
				file = "/proc/#{pid}/statm".freeze
				return nil unless File.readable?(file)

				_virtual_memory = IO.read(file).split[0]
				_virtual_memory ? _virtual_memory.to_i.*(pagesize).fdiv(1000) : nil
			end

			# resident_memory(pid = $$)
			# Where pid is the process ID.
			# By default it is the id of the current process ($$)
			#
			# It retuns the resident memory for the process.
			# The value is in kilobytes.
			# The output is an Integer. For example, a sample output:
			#    13996.032
			#
			# If the info isn't available it will return nil.
			def resident_memory(pid = $$)
				file = "/proc/#{pid}/statm".freeze
				return nil unless File.readable?(file)

				_vm_rss = IO.read(file).split[1]
				_vm_rss ? _vm_rss.to_i.*(pagesize).fdiv(1000) : nil
			end

			# cpu_stat(pid: $$, sleep: 1.0 / LinuxStat::Sysconf.sc_clk_tck)
			# Where pid is the process ID and sleep time is the interval between measurements.
			#
			# By default it is the id of the current process ($$), and sleep is LinuxStat::Sysconf.sc_clk_tck
			# The smallest amount of available sleep time is 1.0 / LinuxStat::Sysconf.sc_clk_tck.
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
			def cpu_stat(pid: $$, sleep: ticks_to_ms)
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

			# cpu_usage(pid: $$, sleep: 1.0 / LinuxStat::Sysconf.sc_clk_tck)
			# Where pid is the process ID and sleep time is the interval between measurements.
			#
			# By default it is the id of the current process ($$), and sleep is 1.0 / LinuxStat::Sysconf.sc_clk_tck
			# The smallest amount of available sleep time is LinuxStat::Sysconf.sc_clk_tck.
			#
			# It retuns the CPU usage in Float.
			# For example:
			#    10.0
			# A value of 100.0 indicates it is using 100% processing power.
			#
			# But if the info isn't available, it will return nil.
			#
			# This method is more efficient than running LinuxStat::ProcessInfo.cpu_stat()
			def cpu_usage(pid: $$, sleep: ticks_to_ms)
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

				data = IO.read(file).split[19]
				data ? data.to_i : nil
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

				IO.read(file).split[38].to_i
			end

			# uid(pid = $$)
			# returns the UIDs of the process as an Array of Integers.
			#
			# If the info isn't available it returns an empty Array.
			def uid(pid = $$)
				file = "/proc/#{pid}/status".freeze
				return nil unless File.readable?(file)

				data = IO.readlines(file.freeze).find { |x|
					x[/Uid.*\d*/]
				}.to_s.split.drop(1)

				{
					real: data[0].to_i,
					effective: data[1].to_i,
					saved_set: data[2].to_i,
					filesystem_uid: data[3].to_i
				}
			end

			# gid(pid = $$)
			# returns the GIDs of the process as an Hash containing the following data:
			# :real, :effective, :saved_set, :filesystem_uid
			#
			# If the info isn't available it returns an empty Hash.
			def gid(pid = $$)
				file = "/proc/#{pid}/status".freeze
				return nil unless File.readable?(file)

				data = IO.readlines(file.freeze).find { |x|
					x[/Gid.*\d*/]
				}.split.drop(1)

				{
					real: data[0].to_i,
					effective: data[1].to_i,
					saved_set: data[2].to_i,
					filesystem_uid: data[3].to_i
				}
			end

			# owner(pid = $$)
			# Returns the owner of the process
			# But if the status is not available, it will return an empty frozen String.
			def owner(pid = $$)
				file = "/proc/#{pid}/status".freeze
				return ''.freeze unless File.readable?(file)

				gid = IO.readlines(file.freeze).find { |x|
					x[/Gid.*\d*/]
				}.split.drop(1)[2].to_i

				LinuxStat::User.username_by_gid(gid)
			end

			private
			def get_ticks
				@@ticks ||= Sysconf.sc_clk_tck
			end

			# Just to avoid multiple calculations!...
			def ticks_to_ms
				@@ms ||= 1.0 / get_ticks
			end

			def pagesize
				@@pagesize ||= LinuxStat::Sysconf.pagesize
			end
		end
	end
end
