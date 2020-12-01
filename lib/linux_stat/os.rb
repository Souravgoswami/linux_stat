module LinuxStat
	module OS
		prepend Uname

		class << self
			# Reads /etc/os-release and returns a Hash. For example:
			# {:NAME=>"Arch Linux", :PRETTY_NAME=>"Arch Linux", :ID=>"arch", :BUILD_ID=>"rolling", :ANSI_COLOR=>"38;2;23;147;209", :HOME_URL=>"https://www.archlinux.org/", :DOCUMENTATION_URL=>"https://wiki.archlinux.org/", :SUPPORT_URL=>"https://bbs.archlinux.org/", :BUG_REPORT_URL=>"https://bugs.archlinux.org/", :LOGO=>"archlinux"}
			#
			# If the info isn't available, it will return an empty Hash.
			#
			# The amount of data read is 4096 bytes. Any more than that will result in truncated output.
			#
			# The information is also cached, and once loaded, won't change in runtime. Because changing the /etc/lsb-release
			# isn't expected in runtime.
			def os_release
				# Cached ; as changing the value in runtime is unexpected
				@@os_release ||= File.readable?('/etc/os-release') ? release('/etc/os-release') : {}
			end

			# Reads /etc/lsb-release and returns a Hash. For example:
			# {:LSB_VERSION=>"1.4", :DISTRIB_ID=>"Arch", :DISTRIB_RELEASE=>"rolling", :DISTRIB_DESCRIPTION=>"Arch Linux"}
			#
			# If the info isn't available, it will return an empty Hash.
			#
			# The amount of data read is 4096 bytes. Any more than that will result in truncated output.
			#
			# The information is also cached, and once loaded, won't change in runtime. Because changing the /etc/lsb-release
			# isn't expected in runtime.
			def lsb_release
				# Cached ; as changing the value in runtime is unexpected
				@@lsb_release ||= File.readable?('/etc/lsb-release') ? release('/etc/lsb-release') : {}
			end

			# Reads /etc/lsb-release or /etc/os-release tries to get information about the distribution.
			# If the information isn't available, it will read and return /etc/issue.
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
					elsif File.readable?('/etc/issue')
						IO.read('/etc/issue').strip
					else
						'Unknown'.freeze
					end
				end
			end

			# Uses utsname.h to determine the machine
			# It returns a String but if the info isn't available, it will return an empty String
			def machine
				@@machine ||= Uname.machine
			end

			# Uses utsname.h to determine the system nodename
			# It returns String but if the info isn't available, it will return an empty String
			def nodename
				@@nodename ||= Uname.nodename
			end

			# Reads /etc/hostname and returns the hostname.
			# The return type is String.
			# If the info info isn't available, it will return 'localhost'.
			def hostname
				@@hostname ||= if File.exist?('/etc/hostname')
					IO.read('/etc/hostname').strip
				else
					'localhost'
				end
			end

			# Reads ruby configuration and tries to guess if the system is 64 bit.
			# If it fails then it runs utsname.h to guess the machine.
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

			# Reads /proc/uptime and returns the system uptime:
			# {:hour=>10, :minute=>34, :second=>12.59}
			#
			# If the stat isn't available, an empty hash is returned.
			def uptime
				return {} unless uptime_readable?

				uptime = IO.read('/proc/uptime').to_f
				uptime_i = uptime.to_i

				h = uptime_i / 3600
				m = uptime_i % 3600 / 60
				s = uptime.%(3600).%(60).round(2)

				{
					hour: h,
					minute: m,
					second: s
				}
			end

			private
			def release(file)
				IO.readlines(file, 4096).reduce({}) { |h, x|
					x.strip!
					next h if x.empty?

					splitted = x.split(?=)

					key = splitted[0].to_s.strip
					value = splitted[1..-1].join(?=).to_s.strip

					value[0] = '' if value[0] == ?"
					value[-1] = '' if value[-1] == ?"

					h.merge!( key.to_sym => value )
				}
			end

			def uptime_readable?
				@@uptime_readable = File.readable?('/proc/uptime')
			end
		end
	end
end
