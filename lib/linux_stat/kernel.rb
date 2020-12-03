module LinuxStat
	module Kernel
		class << self
			# Returns the Linux Kernel version.
			# If the information isn't available, it will return a frozen empty string.
			# The output is also cached ; as changing the value in runtime is unexpected.
			def version
				return ''.freeze if string.empty?
				@@version ||= splitted[2]
			end

			# Returns the name of the user who built the kernel using KBUILD_FLAGS.
			# If the information isn't available, it will return a frozen empty string.
			# The output is also cached ; as changing the value in runtime is unexpected.
			def build_user
				@@build_user ||= string.split(/(\(.+\))/).each(&:strip!)
					.reject(&:empty?).find { |x| x[/^\(.+\)$/] }.to_s
					.split[0].to_s[1..-2].to_s.freeze
			end

			# Returns the compiler used to compile the Linux Kernel.
			# If the information isn't available, it will return a frozen empty string.
			# The output is also cached ; as changing the value in runtime is unexpected.
			def compiler
				return ''.freeze if string.empty?

				@@compiler ||= string.split(/(\(.+\))/).each(&:strip!)
					.reject(&:empty?)
					.find { |x| x[/^\(.+\)$/] }.to_s
					.split.find { |x| !x[/^(.+@.+)$/] }.to_s[/\w+/].to_s.freeze

				@@compiler_val ||= case @@compiler
					when /gcc/i then [:gcc ]
					when /clang/i then [:clang]
					when /icc/i then [:icc]
					else [@@compiler &.to_sym]
				end << compiler_version
			end

			# Returns the compiler version used to compile the Linux Kernel.
			# If the information isn't available, it will return a frozen empty string.
			# The output is also cached ; as changing the value in runtime is unexpected.
			def compiler_version
				@@compiler_version ||= string.split(/(\(.+?\))/).each(&:strip!)
					.reject(&:empty?)[2..4].to_a
					.find { |x| x[/[\d.]+/] }.to_s[/[\d.]+/].to_s.freeze
			end

			# Returns the time when the kernel was compiled.
			# The return value is a Time object.
			# If the information isn't available, it will return nil
			#
			# The time will be searched in specific order.
			# It will match any date matching any of these formats:
			# 1. %b %d %H:%M:%S %z %Y
			# 2. %d %b %Y %H:%M:%S %z
			# 3. %Y-%m-%d
			# Most kernels have date in them in this format.
			#
			# Do note that Ruby sometimes fails to work with timezones like BST for example.
			# In such case, the timezone is unrealiable and often returns the local timezone.
			# You have to use regexp yourself to get the proper zone.
			# Use LinuxStat::Kernel.build_date_string to get the original string if you need that.
			#
			# The output is also cached ; as changing the value in runtime is unexpected.
			def build_date
				return nil if splitted.empty?

				@@time ||= begin
					require 'time' unless Time.respond_to?(:strptime)

					splitted.each_cons(5).map do |x|
						joined = x.each(&:strip!).join(?\s.freeze)

						# Match 21 Oct 2020 01:11:20 +0000
						if joined[/^\d{1,2}\s\w{3}\s\d{4}\s\d{1,2}:\d{1,2}:\d{1,2}\s\+\d*$/]
							Time.strptime(joined, '%d %b %Y %H:%M:%S %Z') rescue nil

						# Match Aug 25 17:23:54 UTC 2020
						elsif joined[/^\w{3}\s\d{1,2}\s\d{1,2}:\d{1,2}:\d{2}\s\w+\s\d*$/]
							Time.strptime(joined, '%b %d %H:%M:%S %z %Y') rescue nil

						# Match 2017-09-19
						elsif joined[/\d{4}-\d{1,2}-\d{1,2}/]
							Time.strptime(joined[/\d{4}-\d{2}-\d{2}/] + " +00:00", '%Y-%m-%d %z') rescue nil

						else
							nil
						end
					end.tap(&:compact!)[0]
				end
			end

			# Returns the time when the kernel was compiled.
			# The return value is a String.
			# If the information isn't available, it will return nil
			#
			# The time will be searched in specific order.
			# It will match any date matching any of these formats:
			# 1. %b %d %H:%M:%S %z %Y
			# 2. %d %b %Y %H:%M:%S %z
			# 3. %Y-%m-%d
			# Most kernels have date in them in this format.
			#
			# Do note that Ruby sometimes fails to work with timezones like BST for example.
			# In such case, the timezone is unrealiable and often returns the local timezone.
			# You have to use regexp yourself to get the proper zone.
			# Use LinuxStat::Kernel.build_date_string to get the original string if you need that.
			#
			# The output is also cached ; as changing the value in runtime is unexpected.
			def build_date_string
				return nil if splitted.empty?

				@@time2 ||= begin
					require 'time' unless Time.respond_to?(:strptime)

					splitted.each_cons(5).map do |x|
						joined = x.each(&:strip!).join(?\s.freeze)

						# Match 21 Oct 2020 01:11:20 +0000
						if (joined[/^\d{1,2}\s\w{3}\s\d{4}\s\d{1,2}:\d{1,2}:\d{1,2}\s\+\d*$/] && (Time.strptime(joined, '%d %b %Y %H:%M:%S %Z') rescue nil)) ||

						# Match Aug 25 17:23:54 UTC 2020
						(joined[/^\w{3}\s\d{1,2}\s\d{1,2}:\d{1,2}:\d{1,2}\s\w+\s\d*$/] && (Time.strptime(joined, '%b %d %H:%M:%S %z %Y') rescue nil)) ||

						# Match 2017-09-19
						(joined[/\d{4}-\d{1,2}-\d{1,2}/] && (Time.strptime(joined[/\d{4}-\d{2}-\d{2}/] + " +00:00", '%Y-%m-%d %z') rescue nil))
							joined
						else
							nil
						end
					end.tap(&:compact!)[0]
				end
			end

			alias release version

			# Reads maximum 1024 bytes from /proc/version and returns the string.
			# The output is also cached ; as changing the value in runtime is unexpected.
			def string
				@@string ||= File.readable?('/proc/version') ? IO.read('/proc/version', 1024).tap(&:strip!) : ''
			end

			# Returns the sc_clk_tck or the same output from command `getconf CLK_TCK`.
			# Also, clk_tck is an alias of this method.
			# The output is also cached ; as changing the value in runtime is unexpected.
			def ticks
				@@tick ||= Sysconf.sc_clk_tck
			end

			alias clk_tck ticks

			private
			def splitted
				@@string_splitted ||= string.split
			end
		end
	end
end
