module LinuxStat
	# Shows various USB device related information of the current system.

	module USB
		class << self
			##
			# = devices_stat(hwdata: true)
			#
			# Returns details about the devices found in /sys/bus/usb/devices/
			#
			# The return value is an Array of multiple Hashes. If there's no info available,
			# it will rather return an empty Array.
			#
			# On Android Termux for example, it can not list the directories because they are
			# not readable the the regular user.
			#
			# It can have information like:
			#
			# path, id, vendor id, product id, manufacturer, serial, bus number, dev number,
			# b_max_power, b_max_packet_size, etc.
			#
			# An example of the returned sample from a test machine is:
			#    LinuxStat::USB.devices_stat
			#
			#    => [{:path=>"/sys/bus/usb/devices/1-1.2/", :id=>"04d9:1203", :vendor_id=>"04d9", :product_id=>"1203", :bus_num=>1, :dev_num=>4, :hwdata=>{:vendor=>"Holtek Semiconductor, Inc.", :product=>"Keyboard"}, :authorized=>true, :b_max_power=>"100mA", :b_max_packet_size0=>8}
			#
			# Right, it's an array of Hashes.
			#
			# It also takes one option. The hwdata, which is true by default.
			#
			# Information about usb devices is found inside /usr/share/hwdata/usb.ids
			#
			# The data contains the vendor and the product.
			#
			# If the option is enabled, it will try look at /usr/share/hwdata/usb.ids
			#
			# But the file will be read only once. The consecutive calls to this method
			# won't open the hwdata all the times.
			#
			# But if there's no hwdata, the Hash returned by this method will not contain
			# hwdata key.
			#
			# The data is only populated if it's available. For example, if there's no
			# manufacturer available for the product, the returned Hash will not contain the
			# information about the manufacturer.
			#
			# Also note that if there's no info available or no USB devices, it will return an empty
			# Hash.
			def devices_stat(hwdata: true)
				@@sys_usb_readable ||= File.executable?('/sys/bus/usb/devices/')
				return [] unless @@sys_usb_readable

				Dir['/sys/bus/usb/devices/*/'.freeze].sort!.map! { |x|
					begin
						id_vendor_file = File.join(x, 'idVendor'.freeze)
						next unless File.readable?(id_vendor_file)
						id_vendor = IO.read(id_vendor_file).strip

						id_product_file = File.join(x, 'idProduct'.freeze)
						next unless File.readable?(id_vendor_file)
						id_product = IO.read(id_product_file).strip

						bus_num_file = File.join(x, 'busnum'.freeze)
						bus_num = File.readable?(bus_num_file) ? IO.read(bus_num_file).strip : ''.freeze

						dev_num_file = File.join(x, 'devnum'.freeze)
						dev_num = File.readable?(dev_num_file) ? IO.read(dev_num_file).strip : ''.freeze

						serial_file = File.join(x, 'serial'.freeze)
						serial = File.readable?(serial_file) ? IO.read(serial_file).strip : ''.freeze

						product_file = File.join(x, 'product'.freeze)
						product = File.readable?(product_file) ? IO.read(product_file).strip : ''.freeze

						manufacturer_file = File.join(x, 'manufacturer'.freeze)
						manufacturer = File.readable?(manufacturer_file) ? IO.read(manufacturer_file).strip : ''.freeze

						removable_file = File.join(x, 'removable'.freeze)
						removable = File.readable?(removable_file) ? IO.read(removable_file).strip.downcase : ''.freeze

						authorized_file = File.join(x, 'authorized'.freeze)
						authorized = File.readable?(authorized_file) ? IO.read(authorized_file).to_i : ''.freeze

						b_max_power_file = File.join(x, 'bMaxPower'.freeze)
						b_max_power = File.readable?(b_max_power_file) ? IO.read(b_max_power_file).strip : ''.freeze

						b_max_packet_size0_file = File.join(x, 'bMaxPacketSize0'.freeze)
						b_max_packet_size0 = File.readable?(b_max_packet_size0_file) ? IO.read(b_max_packet_size0_file).to_i : ''.freeze

						query = hwdata ? query_hwdata(id_vendor, id_product) : {}

						is_removable = if removable == 'removable'.freeze
							true
						elsif removable == 'unknown'.freeze
							nil
						else
							false
						end

						ret = {
							path: x, id: "#{id_vendor}:#{id_product}",
							vendor_id: id_vendor, product_id: id_product
						}

						ret.store(:bus_num, bus_num.to_i) unless bus_num.empty?
						ret.store(:dev_num, dev_num.to_i) unless dev_num.empty?

						ret.store(:serial, serial) unless serial.empty?

						ret.store(:hwdata, query) unless query.empty?
						ret.store(:product, product) unless product.empty?
						ret.store(:manufacturer, manufacturer) unless manufacturer.empty?

						ret.store(:removable, is_removable) unless is_removable.nil?
						ret.store(:authorized, authorized == 1)

						ret.store(:b_max_power, b_max_power) unless b_max_power.empty?
						ret.store(:b_max_packet_size0, b_max_packet_size0) if b_max_packet_size0

						ret
					rescue StandardError
					end
				}.tap(&:compact!)
			end

			##
			# Opens /sys/bus/usb/devices, and counts the total number of
			# devices connected to the USB interface.
			# The return type is an integer.
			#
			# It checks for devices with vendor and product id file.
			# If there's no such file, it will not count them as a USB device.
			#
			# It could be also an integrated hub or a webcam, as well as
			# external hotpluggable devices like printer, USB storage devices,
			# USB mouse, USB keyboard, USB joypad etc.
			#
			# But if the information isn't available, it will return nil.
			def count
				@@sys_usb_readable ||= File.executable?('/sys/bus/usb/devices/')
				return nil unless @@sys_usb_readable

				Dir['/sys/bus/usb/devices/*/'.freeze].count { |x|
					id_vendor_file = File.join(x, 'idVendor'.freeze)
					id_product_file = File.join(x, 'idProduct'.freeze)
					File.readable?(id_vendor_file) && File.readable?(id_product_file)
				}
			end

			##
			# hwdata_file = file
			#
			# Lets you set the hwdata_file about usb.ids.
			#
			# The hwdata file about usb.ids contains vendor name and product name information about
			# devices. This is then mapped by the other methods that utilizes hwdata/usb.ids.
			#
			# Do note that this method is intended to run only once, at the beginning.
			# If you use any other method that utilizes hwdata/usb.ids, before
			# calling this method, this method will not work.
			def hwdata_file=(file)
				@@hwdata_file ||= file.freeze
			end

			##
			# Checks if hwdata_file is already initialized or not.
			# Once it's initialized, calling hwdata_file = 'something/usb.ids' is futile.
			def hwdata_file_set?
				@@hwdata_file ||= nil
				!!@@hwdata_file
			end

			##
			# Returns the hwdata_file as string.
			#
			# If hwdata_file isn't set, it will return an empty frozen string.
			#
			# Once it's set, it can't be changed.
			def hwdata_file
				@@hwdata_file ||= nil
				@@hwdata_file ? @@hwdata_file : ''.freeze
			end

			##
			# Initializes hwdata
			#
			# hwdata can take upto 0.1 to 0.2 seconds to get initialized.
			#
			# Calling this method will load hwdata for future use.
			#
			# Once it's initialized, hwdata_file can't be changed.
			#
			# If this method initializes hwdata, it will return true
			# Othewise this method will return false.
			def initialize_hwdata
				@@hwdata ||= nil
				init = !@@hwdata
				hwdata
				init
			end

			alias count_devices count

			private
			def hwdata
				@@hwdata_file ||= "/usr/share/hwdata/usb.ids".freeze

				@@hwdata ||= if File.readable?(@@hwdata_file)
					file_data = IO.readlines(@@hwdata_file, encoding: 'ASCII-8BIT')
					ret, vendor_id = {}, nil

					i = -1
					file_data_size = file_data.size

					while (i += 1) < file_data_size
						x = file_data[i]

						_lstripped = x.lstrip
						next if _lstripped[0] == ?#.freeze || _lstripped.empty?

						if x[0] == ?\t.freeze
							next unless vendor_id

							x.strip!
							device_id = x[/\A.*?\s/].to_s.strip
							device = x[device_id.length..-1].to_s.strip
							ret[vendor_id][1][device_id] = device
						else
							x.strip!
							vendor_id = x[/\A.*?\s/].to_s.strip
							vendor = x[vendor_id.length..-1].to_s.strip
							ret[vendor_id] = [vendor, {}]
						end
					end

					ret.freeze
				else
					{}
				end
			end

			def query_hwdata(vendor_id, product_id)
				vendor = hwdata[vendor_id]
				if vendor
					{vendor: vendor[0], product: vendor[1][product_id]}
				else
					{}
				end
			end
		end
	end
end
