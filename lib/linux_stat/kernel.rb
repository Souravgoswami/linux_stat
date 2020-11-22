module LinuxStat
	module Kernel
		class << self
			def version
				return @@version ||= ''.freeze if string.empty?
				@@version ||= string.split[2]
			end

			def compiler
				return @@compiler ||= ''.freeze if string.empty?

				@@compiler ||= case string.split[4].to_s
					when /gcc/i then [:gcc ]
					when /clang/i then [:clang]
					when /icc/i then [:icc]
				end << string[/\(.*\)/].split.drop(1).find { |x| x[/^\d.*\d/] }[/^\d.*\d/]
			end

			def build_date
				return @@time ||= Time.new(0) if string.empty?

				@@time ||= begin
					require 'time'
					Time.strptime(string.split[16..-1].join(' '), "%d %b %Y %H:%M:%S %z")
				rescue StandardError
					Time.new(0)
				end
			end

			def string
				# Cached ; as changing the value in runtime is unexpected
				# Hotfix update can be problem, but it's rare and might not
				# affect the version string during program runtime.
				@@string ||= File.readable?('/proc/version') ? IO.read('/proc/version').tap(&:strip!) : ''
			end
		end
	end
end
