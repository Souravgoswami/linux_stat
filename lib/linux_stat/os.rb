module LinuxStat
	# Shows various OS related information of the current system.

	module OS
		class << self
			##
			# Reads /etc/os-release and returns a Hash. For example:
			#    LinuxStat::OS.os_release
			#
			#    => {:NAME=>"Arch Linux", :PRETTY_NAME=>"Arch Linux", :ID=>"arch", :BUILD_ID=>"rolling", :ANSI_COLOR=>"38;2;23;147;209", :HOME_URL=>"https://www.archlinux.org/", :DOCUMENTATION_URL=>"https://wiki.archlinux.org/", :SUPPORT_URL=>"https://bbs.archlinux.org/", :BUG_REPORT_URL=>"https://bugs.archlinux.org/", :LOGO=>"archlinux"}
			#
			# If the info isn't available, it will return an empty Hash.
			#
			# The amount of data read is 4096 bytes. Any more than that will result in truncated output.
			#
			# The information is also cached, and once loaded, won't change in runtime.
			# Because changing the /etc/lsb-release
			# isn't expected in runtime.
			def os_release
				@@os_release ||= File.readable?('/etc/os-release') ? release('/etc/os-release') : {}
			end

			##
			# Reads /etc/lsb-release and returns a Hash. For example:
			#    LinuxStat::OS.lsb_release
			#
			#    => {:LSB_VERSION=>"1.4", :DISTRIB_ID=>"Arch", :DISTRIB_RELEASE=>"rolling", :DISTRIB_DESCRIPTION=>"Arch Linux"}
			#
			# If the info isn't available, it will return an empty Hash.
			#
			# The amount of data read is 4096 bytes. Any more than that will result in truncated output.
			#
			# The information is also cached, and once loaded, won't change in runtime.
			# Because changing the /etc/lsb-release isn't expected in runtime.
			def lsb_release
				@@lsb_release ||= File.readable?('/etc/lsb-release') ? release('/etc/lsb-release') : {}
			end

			##
			# Reads /etc/lsb-release or /etc/os-release tries to get information about the distribution.
			#
			# If the information isn't available, it will read and return /etc/issue.
			#
			# The return type is String.
			# If none of the info is available, it will return an empty frozen String.
			def distribution
				@@distribution ||= if os_release.key?(:NAME)
					os_release[:NAME]
				else
					v = lsb_release

					if v.key?(:DISTRIB_DESCRIPTION)
						v[:DISTRIB_DESCRIPTION]
					elsif v.key?(:DISTRIB_ID)
						v[:DISTRIB_ID]
					elsif File.readable?('/etc/issue'.freeze)
						IO.read('/etc/issue'.freeze, encoding: 'ASCII-8bit'.freeze).strip
					else
						'Unknown'.freeze
					end
				end
			end

			##
			# Gives you the version of the OS you are using.
			#
			# On ArchLinux for example:
			#    LinuxStat::OS.version
			#
			#    => "rolling"
			#
			# On Ubuntu 20.04:
			#    LinuxStat::OS.version
			#
			#    => "20.04"
			#
			# On CentOS 26:
			#    LinuxStat::OS.version
			#
			#    => "26"
			#
			# The return type is String.
			# But if the information isn't available, it will return an empty frozen String.
			def version
				@@distrib_version ||= if os_release.key?(:VERSION_ID)
					os_release[:VERSION_ID]
				elsif lsb_release.key?(:DISTRIB_RELEASE)
					lsb_release[:DISTRIB_RELEASE]
				elsif os_release.key?(:VERSION)
					os_release[:VERSION]
				else
					''.freeze
				end
			end

			##
			# Uses utsname.h to determine the machine
			#
			# It returns a String but if the info isn't available, it will return an empty String
			def machine
				@@machine ||= LinuxStat::Uname.machine
			end

			##
			# Uses utsname.h to determine the system nodename
			#
			# It returns String but if the info isn't available, it will return an empty String.
			def nodename
				LinuxStat::Uname.nodename
			end

			##
			# Returns the hostname from LinuxStat::Sysconf.hostname.
			#
			# The return type is String.
			# If the info info isn't available, it will return an empty String.
			def hostname
				LinuxStat::Sysconf.hostname
			end

			##
			# Reads ruby configuration and tries to guess if the system is 64 bit.
			#
			# If it fails then it runs utsname.h to guess the machine.
			#
			# It the machine is 64 bits, it will return 64, else it returns 32.
			#
			# The return type is strictly Integer and doesn't fail.
			def bits
				@@bits ||= if RbConfig::CONFIG['host_cpu'].end_with?('64') || RUBY_PLATFORM.end_with?('64') || machine.end_with?('64')
					64
				else
					32
				end
			end

			##
			# Reads /proc/uptime and returns the system uptime:
			#    LinuxStat::OS.uptime
			#
			#    => {:hour=>10, :minute=>34, :second=>12.59}
			#
			# Using uptime is 10x slower than using uptime_i
			#
			# If the stat isn't available, an empty hash is returned.
			def uptime
				return {} unless uptime_readable?

				uptime = IO.read('/proc/uptime'.freeze).to_f
				uptime_i = uptime.to_i

				h = uptime_i / 3600
				m = uptime_i % 3600 / 60
				s = uptime.%(3600).%(60).round(2)

				{
					hour: h,
					minute: m,
					second: s
				}.freeze
			end

			##
			# Returns Float uptime of the system reported by /proc/uptime
			#    LinuxStat::OS.uptime_f
			#
			#    => 28956.34
			#
			# The value is generally rounded to 2 decimal places.
			#
			# Using uptime_f is 10x slower than using uptime_i
			#
			# If the stat isn't available, nil is returned.
			def uptime_f
				return nil unless uptime_readable?
				IO.foreach('/proc/uptime'.freeze, ' ').next.to_f
			end

			##
			# Returns uptime of the system reported by LinuxStat::Sysinfo.uptime()
			#    LinuxStat::OS.uptime_i
			#
			#    => 28956
			#
			# If the stat isn't available, nil is returned.
			def uptime_i
				LinuxStat::Sysinfo.uptime
			end

			##
			# The first three fields in this file are load average
              		# figures giving the number of jobs in the run queue (state R)
			# or waiting for disk I/O (state D) averaged over 1, 5,
			# and 15 minutes.  They are the same as the load average
			# numbers given by uptime(1) and other programs.
			# https://man7.org/linux/man-pages/man5/procfs.5.html
			#
			# The return type is an Hash containing the values
			# that maps to 1, 5, and 15.
			# This method calls LinuxStat::Sysinfo.loads() directly.
			#
			# However, if the info isn't available, it will return nil as values.
			def loadavg
				loads = LinuxStat::Sysinfo.loads

				{
					1 => loads[0],
					5 => loads[1],
					15 => loads[2]
				}
			end

			alias distrib_version version

			private
			def release(file)
				IO.readlines(file, 4096).reduce({}) { |h, x|
					x.strip!
					next h if x.empty?

					splitted = x.split(?=.freeze)

					key = splitted[0].to_s
					key.strip!

					value = splitted[1..-1].join(?=.freeze).to_s
					value.strip!

					value[0] = ''.freeze if value[0] == ?".freeze
					value[-1] = ''.freeze if value[-1] == ?".freeze

					h.merge!( key.to_sym => value )
				}
			end

			def uptime_readable?
				@@uptime_readable ||= File.readable?('/proc/uptime')
			end
		end
	end
end
