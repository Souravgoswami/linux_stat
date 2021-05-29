module LinuxStat
	# Helps you convert bytes to a unit like:
	#
	# 1. kilobyte, megabyte, gigabyte, terabyte, petabyte, exabyte, zettabyte, yottabyte
	# 2. kibibyte, mebibyte, gibibyte, tebibyte, pebibyte, exbibyte, zebibyte, yobibyte
	# 3. kB, MB, GB, TB, PB, EB, ZB, YB
	# 4. kiB, MiB, GiB, TiB, PiB, EiB, ZiB, YiB

	module PrettifyBytes
		# Kilo = Kilobyte (1000 - 1), and so on...
		# 8.times { |x| puts 1000.**(x.next).to_s << '.00' }
		KILO = 1000.00
		MEGA = 1000000.00
		GIGA = 1000000000.00
		TERA = 1000000000000.00
		PETA = 1000000000000000.00
		EXA = 1000000000000000000.00
		ZETTA = 1000000000000000000000.00
		YOTTA = 1000000000000000000000000.00

		# Binary prefixes
		# 8.times { |x| puts 1024.**(x.next).to_s << '.00' }
		KILO_B = 1024.00
		MEGA_B = 1048576.00
		GIGA_B = 1073741824.00
		TERA_B = 1099511627776.00
		PETA_B = 1125899906842624.00
		EXA_B = 1152921504606846976.00
		ZETTA_B = 1180591620717411303424.00
		YOTTA_B = 1208925819614629174706176.00

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
			def convert_decimal(n, precision: 2)
				if n < KILO
					"#{"%.#{precision}f" % n} byte#{?s.freeze if n != 1}"
				elsif n < MEGA
					n /= KILO
					"#{"%.#{precision}f" % n} kilobyte#{?s.freeze if n != 1}"
				elsif n < GIGA
					n /= MEGA
					"#{"%.#{precision}f" % n} megabyte#{?s.freeze if n != 1}"
				elsif n < TERA
					n /= GIGA
					"#{"%.#{precision}f" % n} gigabyte#{?s.freeze if n != 1}"
				elsif n < PETA
					n /= TERA
					"#{"%.#{precision}f" % n} terabyte#{?s.freeze if n != 1}"
				elsif n < EXA
					n /= PETA
					"#{"%.#{precision}f" % n} petabyte#{?s.freeze if n != 1}"
				elsif n < ZETTA
					n /= EXA
					"#{"%.#{precision}f" % n} exabyte#{?s.freeze if n != 1}"
				elsif n < YOTTA
					n /= ZETTA
					"#{"%.#{precision}f" % n} zetabyte#{?s.freeze if n != 1}"
				else
					n /= YOTTA
					"#{"%.#{precision}f" % n} yottabyte#{?s.freeze if n != 1}"
				end
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
			def convert_binary(n, precision: 2)
				if n < KILO_B
					"#{"%.#{precision}f" % n} byte#{?s.freeze if n != 1}"
				elsif n < MEGA_B
					n /= KILO_B
					"#{"%.#{precision}f" % n} kibibyte#{?s.freeze if n != 1}"
				elsif n < GIGA_B
					n /= MEGA_B
					"#{"%.#{precision}f" % n} mebibyte#{?s.freeze if n != 1}"
				elsif n < TERA_B
					n /= GIGA_B
					"#{"%.#{precision}f" % n} gibibyte#{?s.freeze if n != 1}"
				elsif n < PETA_B
					n /= TERA_B
					"#{"%.#{precision}f" % n} tebibyte#{?s.freeze if n != 1}"
				elsif n < EXA_B
					n /= PETA_B
					"#{"%.#{precision}f" % n} pebibyte#{?s.freeze if n != 1}"
				elsif n < ZETTA_B
					n /= EXA_B
					"#{"%.#{precision}f" % n} exbiyte#{?s.freeze if n != 1}"
				elsif n < YOTTA_B
					n /= ZETTA_B
					"#{"%.#{precision}f" % n} zebibyte#{?s.freeze if n != 1}"
				else
					n /= YOTTA_B
					"#{"%.#{precision}f" % n} yobibyte#{?s.freeze if n != 1}"
				end
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
			def convert_short_decimal(n, precision: 2)
				if n < KILO
					"#{"%.#{precision}f" % n} B"
				elsif n < MEGA
					n /= KILO
					"#{"%.#{precision}f" % n} kB"
				elsif n < GIGA
					n /= MEGA
					"#{"%.#{precision}f" % n} MB"
				elsif n < TERA
					n /= GIGA
					"#{"%.#{precision}f" % n} GB"
				elsif n < PETA
					n /= TERA
					"#{"%.#{precision}f" % n} TB"
				elsif n < EXA
					n /= PETA
					"#{"%.#{precision}f" % n} PB"
				elsif n < ZETTA
					n /= EXA
					"#{"%.#{precision}f" % n} EB"
				elsif n < YOTTA
					n /= ZETTA
					"#{"%.#{precision}f" % n} ZB"
				else
					n /= YOTTA
					"#{"%.#{precision}f" % n} YB"
				end
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
			def convert_short_binary(n, precision: 2)
				if n < KILO_B
					"#{"%.#{precision}f" % n} B"
				elsif n < MEGA_B
					n /= KILO_B
					"#{"%.#{precision}f" % n} KiB"
				elsif n < GIGA_B
					n /= MEGA_B
					"#{"%.#{precision}f" % n} MiB"
				elsif n < TERA_B
					n /= GIGA_B
					"#{"%.#{precision}f" % n} GiB"
				elsif n < PETA_B
					n /= TERA_B
					"#{"%.#{precision}f" % n} TiB"
				elsif n < EXA_B
					n /= PETA_B
					"#{"%.#{precision}f" % n} PiB"
				elsif n < ZETTA_B
					n /= EXA_B
					"#{"%.#{precision}f" % n} EiB"
				elsif n < YOTTA_B
					n /= ZETTA_B
					"#{"%.#{precision}f" % n} ZiB"
				else
					n = n./(YOTTA_B + 1.0)
					"#{"%.#{precision}f" % n} YiB"
				end
			end
		end
	end
end
