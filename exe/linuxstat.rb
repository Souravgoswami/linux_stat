#!/usr/bin/env ruby
$-v = true

begin
	require 'linux_stat'
rescue LoadError
	abort "The Gem needs to be installed before this test can be run!"
end

# Check which conflicting argument (e.g., `-md -html` together) is passed last
# Always use the last argument
conflicting, hash = [
	"markdown|html", /^\-(\-markdown|md)$/, /^\-(\-html|html)$/
].each_slice(3).to_a, {}

conflicting.each do |x, y, z|
	o1, o2 = *x.split(?|.freeze).map(&:to_sym)
	m1, m2 = ARGV.any? { |_x| _x[y] }, ARGV.any? { |_x| _x[z] }

	if m1 && m2
		rev = ARGV.reverse

		if rev.index { |_x| _x[y] } < rev.index { |_x| _x[z] }
			hash.merge!(o1 => true)
		else
			hash.merge!(o2 => true)
		end
	elsif m1
		hash.merge!(o1 => true)
	elsif m2
		hash.merge!(o2 => true)
	end
end

MARKDOWN, HTML = hash[:markdown], hash[:html]

# Print time each method takes unless --no-time or -nt option is passed
PRINT_TIME = (MARKDOWN || HTML) ? false : !ARGV.any? { |x| x[/^\-\-no-time$/] || x[/^\-nt$/] }

%w(--markdown -md --no-time -nt --html -html).each(&ARGV.method(:delete))

# Run only desired classes / modules
constants = LinuxStat.constants

execute = constants.map(&:downcase).map.with_index { |x, i|
	constants[i] if ARGV.find { |y| y.downcase.to_sym == x }
}.compact

execute.replace(constants) if execute.empty?

execute.sort.each do |c|
	e = eval("LinuxStat::#{c}")

	next if e.class != Module && e.class != Class

	meths = e.methods(false).sort
	next if meths.any? { |a| e.method(a).arity > 0 }

	if meths.length > 0
		if MARKDOWN
			puts "### LinuxStat::#{c}\n```"
		elsif HTML
			puts "<h3>LinuxStat::#{c}</h3>\n<pre>"
		else
			puts "\e[1;4;38;2;255;240;0mLinuxStat::#{c}\e[0m"
		end
	end

	meths.each do |meth|
		time = Time.now
		v = e.send(meth)
		time2 = Time.now
		time = time2.-(time).*(1_000_000).round(3)

		v = v.inspect
		dis = v.length > 253 ? v[0..250].strip + '...'.freeze : v

		if MARKDOWN
			puts "#{e}.#{meth}\n=> #{dis}"
		elsif HTML
			puts "#{e}.#{meth}\n=> #{dis}"
		else
			puts "\e[1;38;2;80;80;255m#{e}.#{meth}\e[0m\n=> #{dis}"
		end

		puts( "(" +
			if time > 10_000
				"\e[1;38;2;255;50;50m"
			elsif time > 5_000
				"\e[1;38;2;255;170;0m"
			else
				"\e[1;38;2;0;170;0m"
			end + "Time taken: #{time}\u03BCs\e[0m)"
		) if PRINT_TIME

		puts
	end

	if meths.length > 0
		if MARKDOWN
			puts "```\n\n"
		elsif HTML
			puts "</pre>"
		end
	end
end
