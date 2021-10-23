module LinuxStat
	# Sensors are available to /sys/class/hwmon
	# This module just reads the files inside them to get the sensor information.
	#
	# https://www.kernel.org/doc/Documentation/thermal/sysfs-api.txt

	module Thermal
		class << self
			##
			# Get temperatures from all sensors.
			#
			# The return value is an Array of Hashes.
			#
			# It opens various files from /sys/, and it should be
			# considered very slow.
			#
			# Each hash may contain information including:
			#
			# path, name, label
			# temperature, temp_crit, temp_max
			#
			# But if the info isn't available, it will return an empty Array.
			def temperatures
				query_hwmon('temp'.freeze, :temperature, true)
			end

			##
			# Get RPM from all fans.
			#
			# The return value is an Array of Hashes.
			#
			# It opens various files from /sys/, and it should be
			# considered very slow.
			#
			# Each hash may contain information including:
			#
			# path, name, label
			# rpm, temp_crit, temp_max
			#
			# But if the info isn't available, it will return an empty Array.
			def fans
				query_hwmon('fan'.freeze, :rpm)
			end

			##
			# Counts the number of sensors (fans are not counted)
			#
			# The return type is an Integer.
			def count_sensors
				return 0 unless hwmon_readable?

				Dir["/sys/class/hwmon/hwmon[0-9]*/temp[0-9]*_input".freeze].size
			end

			##
			# Counts the number of fans (sensors are not counted)
			#
			# The return type is an Integer.
			def count_fans
				return 0 unless hwmon_readable?

				Dir["/sys/class/hwmon/hwmon[0-9]*/fan[0-9]*_input".freeze].size
			end

			private
			def hwmon_readable?
				@@hwmon_readable ||= File.readable?("/sys/class/hwmon/")
			end

			def query_hwmon(mon, key, div = false)
				return [] unless hwmon_readable?

				name = dir = ''.freeze

				files = Dir["/sys/class/hwmon/hwmon[0-9]*/#{mon}[0-9]*_input".freeze]
				i = -1
				ret = []

				while x = files[i += 1]
					splitted = File.split(x)
					path = File.join(splitted[0..-2])

					n = splitted[-1][/.*_/]

					label_f = "#{path}/#{n}label"
					label = File.readable?(label_f) ? IO.read(label_f, encoding: 'ASCII-8BIT'.freeze).strip : nil

					temp_crit_f = "#{path}/#{n}crit"
					temp_crit = File.readable?(temp_crit_f) ? IO.read(temp_crit_f, encoding: 'ASCII-8BIT'.freeze).to_i : nil

					temp_max_f = "#{path}/#{n}max"
					temp_max = File.readable?(temp_max_f) ? IO.read(temp_max_f, encoding: 'ASCII-8BIT'.freeze).to_i : nil

					value = File.readable?(x) ? IO.read(x).to_i : nil

					if dir != path
						dir = path
						name_f = "#{path}/name"
						name = File.readable?(name_f) ? IO.read(name_f, encoding: 'ASCII-8BIT'.freeze).tap(&:strip!) : ''.freeze
					end

					if div
						value /= 1000.0
						temp_max /= 1000.0 if temp_max
						temp_crit /= 1000.0 if temp_crit
					end

					h = {path: path, name: name}

					h.store(:label, label) if label
					h.store(key, value)
					h.store(:temp_crit, temp_crit) if temp_crit
					h.store(:temp_crit, temp_max) if temp_max

					ret.push(h)
				end

				ret
			end
		end
	end
end
