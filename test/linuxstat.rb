#!/usr/bin/env ruby
require 'bundler/setup'
require 'linux_stat'

$-v = true

module LinuxStat
	module Test
		def self.run(*meth)
			constants = LinuxStat.constants.tap { |x| x.delete :Test }

			execute = constants.map(&:downcase).map.with_index { |x, i|
				constants[i] if meth.find { |y| y.downcase.to_sym == x }
			}.compact

			execute.replace(constants) if execute.empty?

			execute.sort.each do |c|
				e = eval("LinuxStat::#{c}")
				next if e.class != Module && e.class != Class
				meths = e.methods(false).sort

				puts "\e[1;4;38;2;255;240;0mLinuxStat::#{c}\e[0m" if meths.length > 0

				meths.each do |meth|
					time = Time.now
					v = e.send(meth)
					time = Time.now.-(time).*(1_000_000).round(3)

					v = v.inspect
					dis = v.length > 253 ? v[0..250].strip + '...'.freeze : v

					puts "\e[1;38;2;80;80;255m#{e}.#{meth}\e[0m\n=> #{dis}"

					puts( "(" +
						if time > 10_000
							"\e[1;38;2;255;50;50m"
						elsif time > 5_000
							"\e[1;38;2;255;170;0m"
						else
							"\e[1;38;2;0;170;0m"
						end + "Time taken: #{time}\u03BCs\e[0m)"
					)

					puts
				end
			end
		end
	end
end
