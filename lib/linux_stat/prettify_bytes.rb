module LinuxStat
	# Helps you convert bytes to a unit like:
	#
	# 1. kilobyte, megabyte, gigabyte, terabyte, petabyte, exabyte, zettabyte, yottabyte
	# 2. kibibyte, mebibyte, gibibyte, tebibyte, pebibyte, exbibyte, zebibyte, yobibyte
	# 3. kB, MB, GB, TB, PB, EB, ZB, YB
	# 4. kiB, MiB, GiB, TiB, PiB, EiB, ZiB, YiB

	module PrettifyBytes
		# Kilo = Kilobyte (1000 - 1), and so on...
		KILO = 1e3
		MEGA = 1e6
		GIGA = 1e9
		TERA = 1e12
		PETA = 1e15
		EXA = 1e18
		ZETTA = 1e21
		YOTTA = 1e24

		# Binary suffixes
		KIBI = 1024.0
		MEBI = KIBI ** 2
		GIBI = KIBI ** 3
		TEBI = KIBI ** 4
		PEBI = KIBI ** 5
		EXBI = KIBI ** 6
		ZEBI = KIBI ** 7
		YOBI = KIBI ** 8

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
					%(#{"%.#{precision}f" % n} kilobyte#{?s.freeze if n. != 1})
				elsif n < GIGA
					n /= MEGA
					%(#{"%.#{precision}f" % n} megabyte#{?s.freeze if n != 1})
				elsif n < TERA
					n /= GIGA
					%(#{"%.#{precision}f" % n} gigabyte#{?s.freeze if n != 1})
				elsif n < PETA
					n /= TERA
					%(#{"%.#{precision}f" % n} terabyte#{?s.freeze if n != 1})
				elsif n < EXA
					n /= PETA
					%(#{"%.#{precision}f" % n} petabyte#{?s.freeze if n != 1})
				elsif n < ZETTA
					n /= EXA
					%(#{"%.#{precision}f" % n} exabyte#{?s.freeze if n != 1})
				elsif n < YOTTA
					n /= ZETTA
					%(#{"%.#{precision}f" % n} zettabyte#{?s.freeze if n != 1})
				else
					n /= YOTTA
					%(#{"%.#{precision}f" % n} yottabyte#{?s.freeze if n != 1})
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
				if n < KIBI
					%Q(#{"%.#{precision}f" % n} byte#{?s.freeze if n != 1})
				elsif n < MEBI
					n /= KIBI
					%Q(#{"%.#{precision}f" % n} kibibyte#{?s.freeze if n != 1})
				elsif n < GIBI
					n /= MEBI
					%Q(#{"%.#{precision}f" % n} mebibyte#{?s.freeze if n != 1})
				elsif n < TEBI
					n /= GIBI
					%Q(#{"%.#{precision}f" % n} gibibyte#{?s.freeze if n != 1})
				elsif n < PEBI
					n /= TEBI
					%Q(#{"%.#{precision}f" % n} tebibyte#{?s.freeze if n != 1})
				elsif n < EXBI
					n /= PEBI
					%Q(#{"%.#{precision}f" % n} pebibyte#{?s.freeze if n != 1})
				elsif n < ZEBI
					n /= EXBI
					%Q(#{"%.#{precision}f" % n} exbiyte#{?s.freeze if n != 1})
				elsif n < YOBI
					n /= ZEBI
					%Q(#{"%.#{precision}f" % n} zebibyte#{?s.freeze if n != 1})
				else
					n /= YOBI
					%Q(#{"%.#{precision}f" % n} yobibyte#{?s.freeze if n != 1})
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
					%(#{"%.#{precision}f" % n.fdiv(KILO)} kB)
				elsif n < GIGA
					%(#{"%.#{precision}f" % n.fdiv(MEGA)} MB)
				elsif n < TERA
					%(#{"%.#{precision}f" % n.fdiv(GIGA)} GB)
				elsif n < PETA
					%(#{"%.#{precision}f" % n.fdiv(TERA)} TB)
				elsif n < EXA
					%(#{"%.#{precision}f" % n.fdiv(PETA)} PB)
				elsif n < ZETTA
					%(#{"%.#{precision}f" % n.fdiv(EXA)} EB)
				elsif n < YOTTA
					%(#{"%.#{precision}f" % n.fdiv(ZETTA)} ZB)
				else
					%(#{"%.#{precision}f" % n.fdiv(YOTTA)} YB)
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
				if n < KIBI
					%(#{"%.#{precision}f" % n} B)
				elsif n < MEBI
					%(#{"%.#{precision}f" % n.fdiv(KIBI)} KiB)
				elsif n < GIBI
					%(#{"%.#{precision}f" % n.fdiv(MEBI)} MiB)
				elsif n < TEBI
					%(#{"%.#{precision}f" % n.fdiv(GIBI)} GiB)
				elsif n < PEBI
					%(#{"%.#{precision}f" % n.fdiv(TEBI)} TiB)
				elsif n < EXBI
					%(#{"%.#{precision}f" % n.fdiv(PEBI)} PiB)
				elsif n < ZEBI
					%(#{"%.#{precision}f" % n.fdiv(EXBI)} EiB)
				elsif n < YOBI
					%(#{"%.#{precision}f" % n.fdiv(ZEBI)} ZiB)
				else
					%(#{"%.#{precision}f" % n.fdiv(YOBI)} YiB)
				end
			end
		end
	end
end
