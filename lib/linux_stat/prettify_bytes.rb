module LinuxStat
	module PrettifyBytes
		class << self
			##
			# Converts a number to decimal byte units and outputs with the metric prefix
			# For example,
			#
			# LinuxStat::PrettifyBytes.convert_decimal(1000)
			#
			# => "1.0 kilobyte"
			#
			# LinuxStat::PrettifyBytes.convert_decimal(1000 ** 3)
			#
			# => "1.0 gigabyte"
			#
			# LinuxStat::PrettifyBytes.convert_decimal(1024 ** 3)
			#
			# => "1.07 gigabytes"
			def convert_decimal(n)
				@@d_units ||= %W(#{''} kilo mega giga tera peta exa zetta)
					.map.with_index { |x, i| [x, 1000.**(i + 1)] }
				unit = @@d_units.find { |x| n < x[1] } || ['yotta'.freeze, 10 ** 27]

				converted = n.fdiv(unit[1] / 1000).round(2)
				"#{pad_left(converted)} #{unit[0]}byte#{?s.freeze if converted != 1}"
			end

			# Converts a number to binary byte units and outputs with the IEC prefix
			# For example,
			#
			# LinuxStat::PrettifyBytes.convert_binary(1000)
			#
			# => "1000.0 bytes"
			#
			# LinuxStat::PrettifyBytes.convert_binary(1000 ** 3)
			#
			# => "953.67 mebibytes"
			#
			# LinuxStat::PrettifyBytes.convert_binary(1024 ** 3)
			#
			# => "1.0 gibibyte"
			def convert_binary(n)
				@@b_units ||= %W(#{''} kibi mebi gibi tebi pebi exbi zebi)
					.map.with_index { |x, i| [x, 1024.**(i + 1)] }
				unit = @@b_units.find { |x| n < x[1] } || ['yobi'.freeze, 10 ** 27]

				converted = n.fdiv(unit[1] / 1024).round(2)
				"#{pad_left(converted)} #{unit[0]}byte#{?s.freeze if converted != 1}"
			end

			# Converts a number to decimal byte units
			# For example,
			#
			# LinuxStat::PrettifyBytes.convert_short_decimal(1000)
			#
			# => "1.0 kB"
			#
			# LinuxStat::PrettifyBytes.convert_short_decimal(1000 ** 3)
			#
			# => "1.0 GB"
			#
			# LinuxStat::PrettifyBytes.convert_short_decimal(1024 ** 3)
			#
			# => "1.07 GB"
			def convert_short_decimal(n)
				@@sd_units ||= %W(#{''} k M G T P E Z)
					.map.with_index { |x, i| [x, 1000.**(i + 1)] }
				unit = @@sd_units.find { |x| n < x[1] } || [?Y.freeze, 10 ** 27]

				converted = n.fdiv(unit[1] / 1000).round(2)
				"#{pad_left(converted)} #{unit[0]}B"
			end

			##
			# Converts a number to binary byte units
			#
			# For example,
			#
			# LinuxStat::PrettifyBytes.convert_short_binary(1000)
			#
			# => "1000 B"
			#
			# LinuxStat::PrettifyBytes.convert_short_binary(1000 ** 3)
			#
			# => "953.67 MiB"
			#
			# LinuxStat::PrettifyBytes.convert_short_binary(1024 ** 3)
			#
			# => "1.0 GiB"
			def convert_short_binary(n)
				return "#{n} B" if n < 1024

				@@sb_units ||= %W(#{''} K M G T P E Z)
					.map.with_index { |x, i| [x, 1024.**(i + 1)] }
				unit = @@sb_units.find { |x| n < x[1] } || [?Y.freeze, 1024 ** 9]

				converted = n.fdiv(unit[1] / 1024).round(2)
				"#{pad_left(converted)} #{unit[0]}iB"
			end

			private
			def pad_left(n, mantissa_length = 2)
				sprintf("%.#{mantissa_length}f".freeze, n)
			end
		end
	end
end
