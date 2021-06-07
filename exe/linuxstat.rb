#!/usr/bin/env ruby
$-v = true

begin
	require 'linux_stat' unless defined?(LinuxStat)
rescue LoadError
	abort "The Gem needs to be installed before this test can be run!"
end

# Time reporting format
T_FMT = '%.3f'.freeze

# Check the number of iterations
iterations = (ARGV.find { |x| x.to_i.to_s == x } || 1).to_i

Integer.class_exec do
	define_method(:clamp) { |min, max|
		self < min ? min : self > max ? max : self
	}
end unless 1.respond_to?(:clamp)

# Gradient colour to strings
class String
	def colourize(colour = 1, flip: false)
		colours, line_length = [], -1
		temp = ''

		each_line do |c|
			n, i = c.length, -1

			if line_length != n
				step, line_length = 255.0./(n), n
				colours.clear

				while (i += 1) < n
					l = i.*(step)
					colours.<<(
						case colour
							when 0 then [ l.*(2).to_i.clamp(0, 255), l.to_i.clamp(0, 255), 255.-(l).to_i.clamp(0, 255) ]
							when 1 then [ 255, 255.-(l).to_i.clamp(0, 255), l.to_i.clamp(0, 255) ]
							when 2 then [ l.to_i.clamp(0, 255), 255.-(l).to_i.clamp(0, 255), l.to_i.clamp(0, 255) ]
							when 3 then [ l.*(2).to_i.clamp(0, 255), 255.-(l).to_i.clamp(0, 255), 100.+(l / 2).to_i.clamp(0, 255) ]
							when 4 then [ 30, 255.-(l / 2).to_i.clamp(0, 255), 110.+(l / 2).to_i.clamp(0, 255) ]
							when 5 then [ 255.-(l * 2).to_i.clamp(0, 255), l.to_i.clamp(0, 255), 200 ]
							when 6 then [ 50.+(255 - l).to_i.clamp(0, 255), 255.-(l / 2).to_i.clamp(0, 255), (l * 2).to_i.clamp(0, 255) ]
							else [ l.*(2).to_i.clamp(0, 255), 255.-(l).to_i.clamp(0, 255), 100.+(l / 2).to_i.clamp(0, 255) ]
						end
					)
				end

				colours.reverse! if flip
			end

			i = -1
			temp.concat "\e[38;2;#{colours[i][0]};#{colours[i][1]};#{colours[i][2]}m#{c[i]}" while (i += 1) < n
		end

		temp << "\e[0m".freeze
	end
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
PRINT_TYPE = ARGV.any? { |x| x[/^\-(\-show\-type|t)$/] }
%w(--markdown -md --no-time -nt --html -html --show-type -t).each(&ARGV.method(:delete))

# Run only desired classes / modules
constants = LinuxStat.constants

# Modules to delete from documentation and testing
%i(
	Nproc
).each(&constants.method(:delete))

execute = constants.map(&:downcase).map.with_index { |x, i|
	constants[i] if ARGV.find { |y| y.downcase.to_sym == x }
}.compact

execute.replace(constants) if execute.empty?
HEXAGONS = %W(\u2b22 \u2b23 \u2B53 \u2B1F)

puts " #{HEXAGONS.rotate![0]} LinuxStat: #{LinuxStat::VERSION}"
puts " #{HEXAGONS.rotate![0]} Test Modules: #{execute.size}"
puts " #{HEXAGONS.rotate![0]} Iterations: #{iterations}"

# sleep 2

def get_colour(n)
	if n > 10_000
		"\e[1;38;2;255;50;50m"
	n > 5_000
		"\e[1;38;2;255;170;0m"
	else
		"\e[1;38;2;0;170;0m"
	end
end

iterations.times do
	execute.sort.each do |c|
		e = eval("LinuxStat::#{c}")

		next if e.class != Module && e.class != Class

		meths = e.methods(false).sort

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
			arg = nil

			arity = e.method(meth).arity
			if arity > 0 || arity == -2
				if c == :PrettifyBytes
					arg = rand(10 ** 15)
				elsif c == :FS
					arg = '/'
				else
					next
				end
			end

			params = e.method(meth).parameters
			param = ''
			params.each do |p|
				case p[0]
					when :opt
						param << "#{p[1]}, "
					when :key
						param << "#{p[1]}:, "
					when :req
						_arg = arg ? " = #{arg.inspect}" : ''.freeze
						param << "#{p[1] || 'arg'}#{_arg}, "
				end
			end

			param.chomp!(", ")

			disp_meth = "#{meth}"
			disp_meth.concat(arg ? "(#{param})" : "(#{param})")

			time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
			cputime = Process.times

			ret = arg ? e.send(meth, arg) : e.send(meth)

			time2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
			cputime2 = Process.times

			time = time2.-(time).*(1_000_000).round(3)
			cputime = cputime2.stime.+(cputime2.utime).-(cputime.stime + cputime.utime).*(1_000_000).round(3)

			v = ret.inspect
			dis = v.length > 253 ? v[0..250].strip + '...'.freeze : v

			source = e.singleton_method(meth).source_location.to_a
			src, src_meth, src_ret = '', '', ''

			unless source.empty?
				src << " File:\t\t#{File.split(source[0])[-1]} | Line: #{source[1]}\n"
				src_meth << " Definition:\t#{IO.foreach(source[0]).first(source[1])[-1].strip}\n"

				src_ret << " Returns:\t" << case ret
					when Array then 'Array | Empty Array'
					when Complex then 'Complex | nil'
					when Float then 'Float | nil'
					when Hash then 'Hash | Empty Hash'
					when Integer then 'Integer | nil'
					when Rational then 'Rational | nil'
					when String then "String | (Frozen) Empty String"
					when Time then 'Time | nil'
					when true, false then 'True or False | nil'
					when nil then 'nil'
					else ''
				end << ?\n.freeze if PRINT_TYPE

				if MARKDOWN || HTML
					src.prepend('#'.freeze)
					src_meth.prepend('#'.freeze)
					src_ret.prepend(?#.freeze) if PRINT_TYPE
				else
					src.prepend(HEXAGONS.rotate![0].freeze)
					src_meth.prepend(HEXAGONS.rotate![0].freeze)
					src_ret.prepend(HEXAGONS.rotate![0].freeze) if PRINT_TYPE
				end
			end

			if MARKDOWN
				puts "#{src}#{src_meth}#{src_ret}#{e}.#{disp_meth}\n=> #{dis}"
			elsif HTML
				puts "#{src}#{src_meth}#{src_ret}#{e}.#{disp_meth}\n=> #{dis}"
			else
				puts "\e[1m#{src.colourize}\e[1m#{src_meth.colourize(6)}\e[1m#{src_ret.colourize(1)}\e[0m\e[1;38;2;80;80;255m#{e}.#{disp_meth}\e[0m\n=> #{dis}"
			end


			if PRINT_TIME
				time_colour = get_colour(time)
				cputime_colour = get_colour(cputime)

				puts "[Real Time: #{time_colour}#{T_FMT % time}\u03BCs\e[0m, "\
				"CPU Time: #{cputime_colour}#{T_FMT % cputime}\u03BCs\e[0m]\n\n"
			end
		end

		if meths.length > 0
			if MARKDOWN
				puts "```\n\n"
			elsif HTML
				puts "</pre>"
			end
		end
	end
end
