#!/usr/bin/env ruby
require 'bundler/setup'
require 'linux_stat'
require 'io/console'

# Print time each method takes unless --no-time or -nt option is passed
PRINT_TIME = !ARGV.any? { |x| x[/^\-\-no-time$/] || x[/^\-nt$/] }

$-v = true

tt = Time.now
wait = 3
anim_delay = wait.fdiv(STDOUT.winsize[1])
anim = %w(| / - \\)

STDOUT.winsize[1].-(20).times do |x|
	t = wait - Time.now.-(tt).to_i
	print "\e[2K#{anim.rotate![0]} Starting test in #{t.clamp(0, wait)} #{?. * x}\r"
	sleep anim_delay
end

print "\e[2K"

LinuxStat.constants.sort.each do |c|
		e = eval("LinuxStat::#{c}")

		next if e.class != Module && e.class != Class

		meths = e.methods(false)

		meths.each do |meth|
			time = Time.now
			v = e.send(meth).to_s
			time = Time.now.-(time).*(1000).round(3)

			dis = v.length > 253 ? v[0..250].strip + '...'.freeze : v
			puts "\e[1;38;2;80;80;255m#{e}.#{meth}\e[0m", "=> #{dis}"

			puts( "(" +
				if time > 10
					"\e[1;38;2;255;80;80m"
				elsif time > 5
					"\e[1;38;2;255;170;0m"
				else
					"\e[1;38;2;0;170;0m"
				end + "Time taken: #{time}ms\e[0m)"
			) if PRINT_TIME

			puts
		end
end
