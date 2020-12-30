module LinuxStat
	# Shows various battery related information of the current system.

	module Battery
		PATH = "/sys/class/power_supply/BAT0".freeze

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
				@@mn_file = File.join(PATH, 'model_name')
				return ''.freeze unless File.readable?(@@mn_file)

				IO.read(@@mn_file).tap(&:strip!)
			end

			##
			# Returns the manufacturer of the battery.
			#
			# If the battery is not present or the information is not available, it will return an empty String.
			def manufacturer
				@@manufacturer_file ||= File.join(PATH, 'manufacturer')
				return ''.freeze unless manufacturer_readable?
				IO.read(@@manufacturer_file).tap(&:strip!)
			end

			##
			# Returns the technology of the battery.
			#
			# If the battery is not present or the information is not available, it will return an empty String.
			def technology
				@@technology_file ||= File.join(PATH, 'technology')
				return ''.freeze unless tech_readable?
				IO.read(@@technology_file).tap(&:strip!)
			end

			##
			# Returns the status of the battery.
			# The status generally includes either of the full, charging, discharging and unknown states in most cases.
			#
			# If the battery is not present or the information is not available, it will return an empty frozen String.
			def status
				@@status_file ||= File.join(PATH, 'status'.freeze)
				return ''.freeze unless status_readable?
				IO.read(@@status_file).tap(&:strip!)
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
				status.downcase == 'discharging'.freeze
			end

			##
			# Returns true if the battery status if full, false if the battery status is not full.
			#
			# If the battery is not present or the information is not available, it will return nil.
			def full?
				return nil if status.empty?
				status.downcase == 'full'.freeze
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

			##
			# Returns the charge full design WH of the battery as Integer
			# However if the info isn't available or there's no BAT0 in the system, this will return nil
			def charge_full_design_wh
					# voltage min design
					@@vmd_f ||= File.join(PATH, 'voltage_min_design'.freeze)
					v_m_d = File.readable?(@@vmd_f) ? IO.read(@@vmd_f).to_i : nil

					# charge full design
					@@cfd_f ||= File.join(PATH, 'charge_full_design'.freeze)
					c_f_d = File.readable?(@@cfd_f) ? IO.read(@@cfd_f).to_i : nil

					if v_m_d && c_f_d
						v_m_d.fdiv(1_000_000).*(c_f_d.fdiv(1_000_000)).round(2)
					else
						nil
					end
			end

			##
			# Returns the charge full WH of the battery as Integer
			# However if the info isn't available or there's no BAT0 in the system, this will return nil
			def charge_full_wh
					# voltage min design
					@@vmd_f ||= File.join(PATH, 'voltage_min_design'.freeze)
					v_m_d = File.readable?(@@vmd_f) ? IO.read(@@vmd_f).to_i : nil

					# charge full
					@@cf_f ||= File.join(PATH, 'charge_full'.freeze)
					c_f = File.readable?(@@cf_f) ? IO.read(@@cf_f).to_i : nil

					if v_m_d && c_f
						v_m_d.fdiv(1_000_000).*(c_f.fdiv(1_000_000)).round(2)
					else
						nil
					end
			end

			##
			# Returns the voltage of the battery as Integer
			# However if the info isn't available or there's no BAT0 in the system, this will return nil
			def voltage_now
				@@voltage_file ||= File.join(PATH, 'voltage_now'.freeze)
				@@voltage_readable ||= File.readable?(@@voltage_file)
				return nil unless @@voltage_readable

				IO.read(@@voltage_file, 16).to_f.fdiv(1000000)
			end

			##
			# A linux system can have multiple batteries. This method attempts to
			# find all of them and return a Hash based on the availibility of the
			# information.
			#
			# This method is somewhat slower than other Battery module singleton methods.
			# Because it does various checks and opens various files from /sys/
			#
			# For example, a sample output can be like this (taken on a test system):
			#
			#    LinuxStat::Battery.devices_stat
			#    => {:AC=>{:type=>"Mains", :online=>1}, :BAT0=>{:model=>"DELL CYMGM77", :manufacturer=>"Samsung SDI", :type=>"Battery", :status=>"Full", :capacity=>100, :voltage_min_design=>11.4, :charge_full_design=>3.684, :charge_full_design_wh=>42.0, :voltage_now=>12.558, :charge_now=>2.087, :charge_now_wh=>26.21, :charge_full_wh=>23.79, :charge_percentage=>100.0}, :hidpp_battery_0=>{:model=>"Wireless Keyboard", :manufacturer=>"Logitech", :type=>"Battery", :status=>"Discharging", :online=>1}}
			#
			# If you need info about lots of batteries, use this method.
			# If the informations are not available, it will return empty Hash for each devices.
			# If the system has no batteries, it will return an empty Hash.
			def devices_stat
				h = {}
				Dir["/sys/class/power_supply/*/".freeze].tap(&:sort!).each do |x|
					# model name
					mn_file = File.join(x, 'model_name'.freeze).freeze
					model_name = File.readable?(mn_file) ? IO.read(mn_file).strip : nil

					# manufacturer
					m_f = File.join(x, 'manufacturer'.freeze).freeze
					manufacturer = File.readable?(m_f) ? IO.read(m_f).strip : nil

					# type
					t_f = File.join(x, 'type'.freeze).freeze
					type = File.readable?(t_f) ? IO.read(t_f).strip : nil

					# capacity
					c_file = File.join(x, 'capacity'.freeze).freeze
					capacity = File.readable?(c_file) ? IO.read(c_file).to_i : nil

					# voltage now
					vn_f = File.join(x, 'voltage_now'.freeze).freeze
					voltage_now = File.readable?(vn_f) ? IO.read(vn_f).to_i.fdiv(1_000_000) : nil

					# charge now
					cn_f = File.join(x, 'charge_now'.freeze).freeze
					charge_now = File.readable?(cn_f) ? IO.read(cn_f).to_i.fdiv(1_000_000) : nil

					# voltage min design
					vmd_f = File.join(x, 'voltage_min_design'.freeze).freeze
					v_m_d = File.readable?(vmd_f) ? IO.read(vmd_f).to_i.fdiv(1_000_000) : nil

					# charge full design
					cfd_f = File.join(x, 'charge_full_design'.freeze).freeze
					c_f_d = File.readable?(cfd_f) ? IO.read(cfd_f).to_i.fdiv(1_000_000) : nil

					# charge full
					cf_f = File.join(x, 'charge_full'.freeze).freeze
					charge_full = File.readable?(cf_f) ? IO.read(cf_f).to_i.fdiv(1_000_000) : nil

					# status
					s_f = File.join(x, 'status'.freeze).freeze
					status = File.readable?(s_f) ? IO.read(s_f).strip : nil

					# online
					o_f = File.join(x, 'online'.freeze).freeze
					online = File.readable?(o_f) ? IO.read(o_f).to_i : nil

					charge_percentage = if charge_now && charge_full
						charge_now.*(100).fdiv(charge_full).round(2)
					else
						nil
					end

					# full_charge_design (WH)
					c_f_d_wh =  if c_f_d && v_m_d
						v_m_d.*(c_f_d).round(2)
					else
						nil
					end

					c_n_wh = if voltage_now && charge_now
						voltage_now.*(charge_now).round(2)
					else
						nil
					end

					c_f_wh = if v_m_d && charge_full
						v_m_d.*(charge_full).round(2)
					else
						nil
					end

					ret = {}
					ret[:model] = model_name if model_name
					ret[:manufacturer] = manufacturer if manufacturer
					ret[:type] = type if type

					ret[:status] = status if status
					ret[:online] = online if online
					ret[:capacity] = capacity if capacity

					ret[:voltage_min_design] = v_m_d if v_m_d
					ret[:charge_full_design] = c_f_d if c_f_d
					ret[:charge_full_design_wh] = c_f_d_wh if c_f_d_wh

					ret[:voltage_now] = voltage_now if voltage_now
					ret[:charge_now] = charge_now if charge_now

					ret[:charge_now_wh] = c_n_wh if c_n_wh
					ret[:charge_full_wh] = c_f_wh if c_f_wh
					ret[:charge_percentage] = charge_percentage if charge_percentage

					h.merge!(File.split(x)[-1].to_sym => ret)
				end
				h
			end

			private
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
