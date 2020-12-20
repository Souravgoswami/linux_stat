module LinuxStat
	module Battery
		PATH = "/sys/class/power_supply/BAT0"

		class << self
			##
			# Returns true or false based on the presence of the battery.
			def present?
				@@present ||= Dir.exist?(PATH)
			end

			##
			# Returns the details of the battery.
			#
			# If the battery is not present it will return an empty Hash.
			def stat
				st = status.downcase
				return {} unless present?

				{
					model: model,
					manufacturer: manufacturer,
					technology: technology,
					status: status,
					charge: charge,
					charging: %w(full charging unknown).each(&:freeze).include?(st),
					discharging: st == 'discharging'.freeze,
					full: st == 'full'.freeze,
				}
			end

			##
			# Returns the model of the battery.
			#
			# If the battery is not present or the information isn't available it will return an empty String.
			def model
				return ''.freeze unless model_readable?
				IO.read(File.join(PATH, 'model_name')).tap(&:strip!)
			end

			##
			# Returns the manufacturer of the battery.
			#
			# If the battery is not present or the information is not available, it will return an empty String.
			def manufacturer
				return ''.freeze unless manufacturer_readable?
				IO.read(File.join(PATH, 'manufacturer')).tap(&:strip!)
			end

			##
			# Returns the technology of the battery.
			#
			# If the battery is not present or the information is not available, it will return an empty String.
			def technology
				return ''.freeze unless tech_readable?
				IO.read(File.join(PATH, 'technology')).tap(&:strip!)
			end

			##
			# Returns the status of the battery.
			# The status generally includes either of the full, charging, discharging and unknown states in most cases.
			#
			# If the battery is not present or the information is not available, it will return an empty frozen String.
			def status
				return ''.freeze unless status_readable?
				IO.read(File.join(PATH, 'status')).tap(&:strip!)
			end

			##
			# Returns true if the battery is charging, false if the battery is not charging.
			#
			# If the battery is not present or the information is not available, it will return nil.
			def charging?
				return nil if status.empty?
				%w(full charging unknown).each(&:freeze).include?(status.downcase)
			end

			##
			# Returns true if the battery is discharging, false if the battery is not discharging.
			#
			# If the battery is not present or the information is not available, it will return nil.
			def discharging?
				return nil if status.empty?
				status.downcase == 'discharging'
			end

			##
			# Returns true if the battery status if full, false if the battery status is not full.
			#
			# If the battery is not present or the information is not available, it will return nil.
			def full?
				return nil if status.empty?
				status.downcase == 'full'
			end

			##
			# Returns the charge of the battery.
			#
			# If the battery is not present or the information is not available, it will return nil.
			def charge
				@@charge_now_file ||= File.join(PATH, 'charge_now')
				@@charge_full_file ||= File.join(PATH, 'charge_full')

				@@charge_now_readable ||= File.readable?(@@charge_now_file) && File.readable?(@@charge_full_file)
				return nil unless @@charge_now_readable

				charge_now = IO.read(@@charge_now_file).to_i
				charge_full = IO.read(@@charge_full_file).to_i

				percentage = charge_now.*(100).fdiv(charge_full)
				percentage > 100 ? 100.0 : percentage < 0 ? 0.0 : percentage
			end

			def voltage_now
				@@voltage_file ||= File.join(PATH, 'voltage_now'.freeze)
				@@voltage_readable ||= File.readable?(@@voltage_file)
				return nil unless @@voltage_readable

				IO.read(@@voltage_file, 16).to_f.fdiv(1000000)
			end

			private
			def model_readable?
				@@model_readable ||= File.readable?(File.join(PATH, 'model_name'))
			end

			def manufacturer_readable?
				@@manufacturer_readable ||= File.readable?(File.join(PATH, 'manufacturer'))
			end

			def tech_readable?
				@@tech_readable ||= File.readable?(File.join(PATH, 'technology'))
			end

			def status_readable?
				@@status_readable ||= File.readable?(File.join(PATH, 'status'))
			end
		end
	end
end
