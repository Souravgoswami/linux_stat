module LinuxStat
	module Battery
		PATH = "/sys/class/power_supply/BAT0"

		class << self
			def present?
				@@present ||= Dir.exist?(PATH)
			end

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

			def model
				return ''.freeze unless model_readable?
				IO.read(File.join(PATH, 'model_name')).tap(&:strip!)
			end

			def manufacturer
				return ''.freeze unless manufacturer_readable?
				IO.read(File.join(PATH, 'manufacturer')).tap(&:strip!)
			end

			def technology
				return ''.freeze unless tech_readable?
				IO.read(File.join(PATH, 'technology')).tap(&:strip!)
			end

			def status
				return ''.freeze unless status_readable?
				IO.read(File.join(PATH, 'status')).tap(&:strip!)
			end

			def charging?
				%w(full charging unknown).each(&:freeze).include?(status.downcase)
			end

			def discharging?
				status.downcase == 'discharging'
			end

			def full?
				status.downcase == 'full'
			end

			def charge
				return 0.0 unless charge_now_readable?
				charge_now = IO.read(File.join(PATH, 'charge_now')).to_i
				charge_full = IO.read(File.join(PATH, 'charge_full')).to_i

				percentage = charge_now.*(100).fdiv(charge_full)
				percentage = percentage > 100 ? 100.0 : percentage < 0 ? 0.0 : percentage
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

			def charge_now_readable?
				@@charge_now_readable ||= File.readable?(File.join(PATH, 'charge_now')) &&
					File.readable?(File.join(PATH, 'charge_full'))
			end
		end
	end
end
