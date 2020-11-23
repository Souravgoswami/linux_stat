module LinuxStat
	module OS
		class << self
			def os_release
				# Cached ; as changing the value in runtime is unexpected
				@@os_release ||= File.readable?('/etc/os-release') ? release('/etc/os-release') : {}
			end

			def lsb_release
				# Cached ; as changing the value in runtime is unexpected
				@@lsb_release ||= File.readable?('/etc/lsb-release') ? release('/etc/lsb-release') : {}
			end

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

			def hostname
				@@hostname ||= if File.exist?('/etc/hostname')
					IO.read('/etc/hostname').strip
				else
					'localhost'
				end
			end

			def bits
				@@bits ||= if RbConfig::CONFIG['host_cpu'].end_with?('64') || RUBY_PLATFORM[/x86_64/]
					64
				else
					32
				end
			end

			def uptime
				raise StatUnavailable, 'Cannot read /proc/uptime' unless uptime_readable?

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
				IO.readlines(file, 3000).reduce({}) { |h, x|
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
