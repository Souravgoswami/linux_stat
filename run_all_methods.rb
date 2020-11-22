#!/usr/bin/env ruby
require 'bundler/setup'
require 'linux_stat'
require 'io/console'

# Print time each method takes unless --no-time or -nt option is passed
MARKDOWN = ARGV.any? { |x| x[/^\-\-markdown$/] || x[/^\-md$/] }
PRINT_TIME = MARKDOWN ? false : !ARGV.any? { |x| x[/^\-\-no-time$/] || x[/^\-nt$/] }

$-v = true

LinuxStat.constants.sort.each do |c|
	e = eval("LinuxStat::#{c}")

	next if e.class != Module && e.class != Class

	meths = e.methods(false)

	if meths.length > 0
		if MARKDOWN
			puts "### LinuxStat::#{c}\n```"
		else
			puts "\e[1;4;38;2;255;240;0mLinuxStat::#{c}\e[0m"
		end
	end

	meths.each do |meth|
		time = Time.now
		v = e.send(meth).to_s
		time = Time.now.-(time).*(1000).round(3)

		dis = v.length > 253 ? v[0..250].strip + '...'.freeze : v

		if MARKDOWN
			puts "#{e}.#{meth}\n=> #{dis}"
		else
			puts "\e[1;38;2;80;80;255m#{e}.#{meth}\e[0m\n=> #{dis}"
		end

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

	puts "```\n\n" if MARKDOWN && meths.length > 0
end
