module LinuxStat
	module Kernel
		class << self
			def version
				return ''.freeze if string.empty?
				@@version ||= splitted[2]
			end

			def build_user
				@@build_user ||= string.split(/(\(.+\))/).each(&:strip!)
					.reject(&:empty?).find { |x| x[/^\(.+\)$/] }.to_s
					.split[0].to_s[1..-2].to_s
			end

			def compiler
				return ''.freeze if string.empty?

				@@compiler ||= string.split(/(\(.+\))/).each(&:strip!)
					.reject(&:empty?)
					.find { |x| x[/^\(.+\)$/] }.to_s
					.split.find { |x| !x[/^(.+@.+)$/] }.to_s[/\w+/].to_s

				@@compiler_val ||= case @@compiler
					when /gcc/i then [:gcc ]
					when /clang/i then [:clang]
					when /icc/i then [:icc]
					else [@@compiler &.to_sym]
				end << compiler_version
			end

			def compiler_version
				@@compiler_version ||= string.split(/(\(.+?\))/).each(&:strip!)
					.reject(&:empty?)[2..4].to_a
					.find { |x| x[/[\d.]+/] }.to_s[/[\d.]+/].to_s
			end

			def build_date
				return @@time ||= Time.new(0) if string.empty?

				@@time ||= begin
					require 'time'

					time = splitted.each_slice(8).find do |x|
						x.each(&:strip!)
						p Time.strptime(x.join(?\s.freeze), '%d %b %Y %H:%M:%S %z'.freeze) rescue nil
					end

					time ? Time.strptime(time.join(?\s.freeze), "%d %b %Y %H:%M:%S %z") : Time.new(0)
				end
			end

			def string
				# Cached ; as changing the value in runtime is unexpected
				# Hotfix update can be problem, but it's rare and might not
				# affect the version string during program runtime.
				@@string ||= File.readable?('/proc/version') ? IO.read('/proc/version', 1000).tap(&:strip!) : ''
			end

			private
			def splitted
				@@string_splitted ||= string.split
			end
		end
	end
end
