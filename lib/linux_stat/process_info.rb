module LinuxStat
	module ProcessInfo
		class << self
			##
			# = total_io(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the total read/write caused by a process.
			#
			# The output is Hash.
			#
			# For example:
			#    LinuxStat::ProcessInfo.total_io
			#
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

			##
			# = cmdline(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the total command of the process.
			#
			# The output is String. For example:
			#    LinuxStat::ProcessInfo.cmdline
			#
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

			##
			# = command_name(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the total command name of the process.
			#
			# The output is String. For example:
			#    LinuxStat::ProcessInfo.command_name
			#
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

			##
			# = mem_stat(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the memory, virtual memory, and resident memory of the process.
			#
			# All values are in kilobytes.
			#
			# The output is a Hash. For example:
			#    LinuxStat::ProcessInfo.mem_stat
			#
			#    {:memory=>8515.584, :virtual_memory=>79781.888, :resident_memory=>13955.072}
			#
			# * Note:
			# 1. If you need only memory usage of a process, run LinuxStat::ProcessInfo.memory(pid)
			# 2. If you need only virtual memory for a process, run LinuxStat::ProcessInfo.virtual_memory(pid)
			# 3. If you need only resident memory of a process, run LinuxStat::ProcessInfo.resident_memory(pid)
			#
			# This method opens opens multiple files.
			#
			# But if you need all of the info, then running this method once is efficient.
			#
			# If the info isn't available it will return an empty Hash.
			def mem_stat(pid = $$)
				statm = "/proc/#{pid}/statm".freeze
				return {} unless File.readable?(statm)

				data = IO.read(statm).split

				_rss_anon = (data[1] && data[2]) ? data[1].to_i.-(data[2].to_i).*(pagesize).fdiv(1000) : nil
				_virtual_memory = data[0] ? data[0].to_i*(pagesize).fdiv(1000) : nil
				_resident_memory = data[1] ? data[1].to_i.*(pagesize).fdiv(1000) : nil

				{
					memory: _rss_anon,
					virtual_memory: _virtual_memory,
					resident_memory: _resident_memory
				}
			end

			##
			# = memory(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the memory of the process.
			# The value is in kilobytes.
			#
			# The output is an Integer. For example:
			#    LinuxStat::ProcessInfo.memory
			#
			#    8523.776
			#
			# If the info isn't available it will return nil.
			def memory(pid = $$)
				file = "/proc/#{pid}/statm".freeze
				return nil unless File.readable?(file)

				data = IO.read(file).split
				(data[1] && data[2]) ? data[1].to_i.-(data[2].to_i).*(pagesize).fdiv(1000) : nil
			end

			##
			# = virtual_memory(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the virtual memory for the process.
			#
			# The value is in kilobytes.
			#
			# The output is an Integer. For example:
			#    LinuxStat::ProcessInfo.virtual_memory
			#
			#    79781.888
			#
			# If the info isn't available it will return nil.
			def virtual_memory(pid = $$)
				file = "/proc/#{pid}/statm".freeze
				return nil unless File.readable?(file)

				_virtual_memory = IO.read(file).split[0]
				_virtual_memory ? _virtual_memory.to_i.*(pagesize).fdiv(1000) : nil
			end

			##
			# = resident_memory(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the resident memory for the process.
			#
			# The value is in kilobytes.
			#
			# The output is an Integer. For example:
			#    LinuxStat::ProcessInfo.cpu_stat
			#
			#    => 13996.032
			#
			# If the info isn't available it will return nil.
			def resident_memory(pid = $$)
				file = "/proc/#{pid}/statm".freeze
				return nil unless File.readable?(file)

				_vm_rss = IO.read(file).split[1]
				_vm_rss ? _vm_rss.to_i.*(pagesize).fdiv(1000) : nil
			end

			##
			# = cpu_stat(pid: $$, sleep: 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5)
			#
			# Where pid is the process ID and sleep time is the interval between measurements.
			#
			# By default it is the id of the current process ($$), and sleep is LinuxStat::Sysconf.sc_clk_tck
			#
			# The smallest amount of available sleep time is 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5.
			#
			# * Note 1:
			# 1. Do note that the sleep time can slow down your application.
			# 2. And it's only needed for the cpu usage calculation.
			#
			# It retuns the CPU usage, threads, and the last executed CPU in Hash.
			#
			# For example:
			#    LinuxStat::ProcessInfo.cpu_stat
			#
			#    => {:cpu_usage=>0.0, :threads=>1, :last_executed_cpu=>1}
			#
			# But if the info isn't available, it will return an empty Hash.
			#
			# The :cpu_usage is in percentage.
			# It's also divided with the number of CPU.
			#
			# :cpu_usage for example, will return 25.0 if the CPU count
			# is 4, and the process is using 100% of a thread / core.
			#
			# A value of 100.0 indicates it is using 100% processing power available to the system.
			#
			# The :threads returns the number of threads for the process.
			# The value is a Integer.
			#
			# * Note 2:
			# 1. If you just need the CPU usage run LinuxStat::ProcessInfo.cpu_usage(pid = $$)
			# 2. If you just need the threads run LinuxStat::ProcessInfo.threads(pid = $$)
			# 3. If you just need the last executed CPU run LinuxStat::ProcessInfo.last_executed_cpu(pid = $$)
			# 4. Running this method is slower and it opens multiple files at once
			#
			# Only use this method if you need all of the data at once, in such case, it's more efficient to use this method.
			#
			# The :last_executed_cpu also returns an Integer indicating the last executed cpu of the process.
			def cpu_stat(pid: $$, sleep: ticks_to_ms_t5)
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

			##
			# = cpu_usage(pid: $$, sleep: 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5)
			#
			# Where pid is the process ID and sleep time is the interval between measurements.
			#
			# By default it is the id of the current process ($$), and sleep is 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5
			#
			# The smallest amount of available sleep time is LinuxStat::Sysconf.sc_clk_tck.
			#
			# It retuns the CPU usage as Float.
			#
			# For example:
			#
			#    LinuxStat::ProcessInfo.cpu_usage
			#
			#    => 10.0
			#
			# A value of 100.0 indicates it is using 100% processing power available to the system.
			#
			# But if the info isn't available, it will return nil.
			#
			# This method is more efficient than running LinuxStat::ProcessInfo.cpu_stat()
			def cpu_usage(pid: $$, sleep: ticks_to_ms_t5)
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

			##
			# = thread_usage(pid: $$, sleep: 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5)
			#
			# Where pid is the process ID and sleep time is the interval between measurements.
			#
			# By default it is the id of the current process ($$), and sleep is 1.0 / LinuxStat::Sysconf.sc_clk_tck * 5
			#
			# The smallest amount of available sleep time is LinuxStat::Sysconf.sc_clk_tck.
			#
			# It retuns the per core CPU usage as Float.
			#
			# For example:
			#
			#    LinuxStat::ProcessInfo.core_usage
			#
			#    => 200.0
			#
			# A value of 100.0 indicates it is using 100% processing power of a core.
			#
			# The value could be 0 to (100 * the number of CPU threads (including hyperthreading) in the system)
			#
			# But if the info isn't available, it will return nil.
			def thread_usage(pid: $$, sleep: ticks_to_ms_t5)
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
				totald.-(idle2 - idle1).fdiv(totald).*(100).round(2).abs
			end

			##
			# = threads(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the threads for the current process in Integer.
			#
			# For example:
			#    LinuxStat::ProcessInfo.threads
			#
			#    => 2
			#
			# But if the info isn't available, it will return nil.
			#
			# This method is way more efficient than running LinuxStat::ProcessInfo.cpu_stat()
			def threads(pid = $$)
				file = "/proc/#{pid}/stat".freeze
				return nil unless File.readable?(file)

				data = IO.foreach(file, ' '.freeze).first(20)[-1]
				data ? data.to_i : nil
			end

			##
			# = last_executed_cpu(pid = $$)
			#
			# Where pid is the process ID.
			#
			# By default it is the id of the current process ($$)
			#
			# It retuns the last executed CPU in Integer.
			#
			# For example:
			#    LinuxStat::ProcessInfo.last_executed_cpu
			#
			#    => 2
			#
			# But if the info isn't available, it will return nil.
			#
			# This method is way more efficient than running LinuxStat::ProcessInfo.cpu_stat()
			def last_executed_cpu(pid = $$)
				file = "/proc/#{pid}/stat".freeze
				return nil unless File.readable?(file)

				IO.read(file).split[38].to_i
			end

			##
			# = uid(pid = $$)
			#
			# returns the UIDs of the process as an Array of Integers.
			#
			# If the info isn't available it returns an empty Array.
			def uid(pid = $$)
				file = "/proc/#{pid}/status".freeze
				return nil unless File.readable?(file)

				data = IO.foreach(file.freeze).find { |x|
					x[/Uid.*\d*/]
				}.to_s.split.drop(1)

				{
					real: data[0].to_i,
					effective: data[1].to_i,
					saved_set: data[2].to_i,
					filesystem_uid: data[3].to_i
				}
			end

			##
			# = gid(pid = $$)
			#
			# returns the GIDs of the process as an Hash containing the following data:
			#
			#    :real, :effective, :saved_set, :filesystem_uid
			#
			# If the info isn't available or the argument passed doesn't exist as a process ID, it will return an empty Hash.
			def gid(pid = $$)
				file = "/proc/#{pid}/status".freeze
				return nil unless File.readable?(file)

				data = IO.foreach(file.freeze).find { |x|
					x[/Gid.*\d*/]
				}.split.drop(1)

				{
					real: data[0].to_i,
					effective: data[1].to_i,
					saved_set: data[2].to_i,
					filesystem_uid: data[3].to_i
				}
			end

			##
			# = owner(pid = $$)
			#
			# Returns the owner of the process
			# But if the status is not available, it will return an empty frozen String.
			def owner(pid = $$)
				file = "/proc/#{pid}/status".freeze
				return ''.freeze unless File.readable?(file)

				gid = IO.foreach(file.freeze).find { |x|
					x[/Gid.*\d*/]
				}.split.drop(1)[2].to_i

				LinuxStat::User.username_by_gid(gid)
			end

			##
			# = start_time_epoch(pid = $$)
			#
			# Returns the epoch time (as Integer) the process was started.
			#
			# For example:
			#    LinuxStat::ProcessInfo.start_time_epoch 526
			#
			#    => 1608097744
			#
			# If the info isn't available or the argument passed doesn't exist as a process ID, it will return nil.
			def start_time_epoch(pid = $$)
				stat_file = "/proc/#{pid}/stat".freeze
				uptime = "/proc/uptime".freeze

				@@u_readable ||= File.readable?(uptime)
				return nil unless @@u_readable && File.readable?(stat_file)

				u = IO.foreach(uptime, ' '.freeze).next.to_f
				st = (IO.foreach(stat_file, ' '.freeze).first(22)[-1].to_f / get_ticks)

				# Getting two Time objects and dealing with floating point numbers
				# Just to make sure the time goes monotonically
				Time.now.-(u - st).to_i
			end

			##
			# = start_time(pid = $$)
			#
			# Returns the time (as Time object) the process was started.
			#
			# For example:
			#    LinuxStat::ProcessInfo.start_time 14183
			#
			#    => 2020-12-16 13:31:43 +0000
			#
			# If the info isn't available or the argument passed doesn't exist as a process ID, it will return nil.
			#
			# The timezone returned based on current TZ.
			# Thus the timezone could be affected by changing the ENV['TZ'] variable.
			#
			# Don't trust the timezone returned by the time.
			def start_time(pid = $$)
				# Getting two Time objects and dealing with floating point numbers
				# Just to make sure the time goes monotonically
				Time.at(start_time_epoch(pid))
			end

			##
			# = running_time(pid = $$)
			#
			# Returns the time (in seconds, as Float) the process is running for.
			#
			# For example:
			#    LinuxStat::ProcessInfo.running_time 14183
			#
			#    => 1947.619999999999
			#
			# If the info isn't available or the argument passed doesn't exist as a process ID, it will return nil.
			def running_time(pid = $$)
				stat_file = "/proc/#{pid}/stat".freeze
				uptime = "/proc/uptime".freeze

				@@u_readable ||= File.readable?(uptime)
				return nil unless @@u_readable && File.readable?(stat_file)

				IO.foreach(uptime, ' '.freeze).next.to_f - (IO.read(stat_file).split[21].to_i / get_ticks)
			end

			##
			# = state(pid = $$)
			# Returns the state of the process as a frozen String
			#
			# * A process could have multiple states:
			#
			# 1. S => Sleeping
			#
			# 2. R => Running
			#
			# 3. I => Idle
			#
			# 4. Z => Zombie
			#
			# It returns any one of them.
			#
			# If the info isn't available or the argument passed doesn't exist as a process ID,
			# it will return an empty String.
			def state(pid = $$)
				file = "/proc/#{pid}/stat".freeze
				return ''.freeze unless File.readable?(file)
				IO.foreach(file, ' '.freeze).first(3)[-1].tap(&:rstrip!).freeze
			end

			##
			# = nice(pid = $$)
			# Returns the nice of the process
			#
			# The output value is an Integer ranging from -20 to 19
			#
			# -20 means the process has high priority, and 19 means the process has low priority
			#
			# If the info isn't available or the argument passed doesn't exist as a process ID, it will return nil.
			def nice(pid = $$)
				file = "/proc/#{pid}/stat"
				return nil unless File.readable?(file)

				IO.foreach(file, ' ').first(19)[-1].to_i
			end

			private
			def get_ticks
				@@ticks ||= Sysconf.sc_clk_tck
			end

			# Just to avoid multiple calculations!...
			# ticks to ms * 5
			# If ticks is 100, it will return 0.05
			def ticks_to_ms_t5
				@@ms_t5 ||= 1.0 / get_ticks * 5
			end

			def pagesize
				@@pagesize ||= LinuxStat::Sysconf.pagesize
			end
		end
	end
end
