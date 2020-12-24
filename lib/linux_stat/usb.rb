module LinuxStat
	module USB
		class << self
			def devices_stat
				Dir['/sys/bus/usb/devices/*/'.freeze].sort!.map! { |x|
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
					removable = File.readable?(removable_file) ? IO.read(removable_file).strip : ''.freeze

					authorized_file = File.join(x, 'authorized'.freeze)
					authorized = File.readable?(authorized_file) ? IO.read(authorized_file).to_i : ''.freeze

					b_max_power_file = File.join(x, 'bMaxPower'.freeze)
					b_max_power = File.readable?(b_max_power_file) ? IO.read(b_max_power_file).strip : ''.freeze

					b_max_packet_size0_file = File.join(x, 'bMaxPacketSize0'.freeze)
					b_max_packet_size0 = File.readable?(b_max_packet_size0_file) ? IO.read(b_max_packet_size0_file).to_i : ''.freeze

					query = query_hwdata(id_vendor, id_product)

					removable.downcase!
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

					ret.merge!(bus_num: bus_num.to_i) unless bus_num.empty?
					ret.merge!(dev_num: dev_num.to_i) unless dev_num.empty?

					ret.merge!(serial: serial) unless serial.empty?

					ret.merge!(hwdata: query) unless query.empty?
					ret.merge!(product: product) unless product.empty?
					ret.merge!(manufacturer: manufacturer) unless manufacturer.empty?

					ret.merge!(removable: is_removable) unless is_removable.nil?
					ret.merge!(authorized: authorized == 1)

					ret.merge!(b_max_power: b_max_power) unless b_max_power.empty?
					ret.merge!(b_max_packet_size0: b_max_packet_size0) if b_max_packet_size0
				}.tap(&:compact!)
			end

			def count
				Dir['/sys/bus/usb/devices/*/'.freeze].count { |x|
					id_vendor_file = File.join(x, 'idVendor'.freeze)
					id_product_file = File.join(x, 'idProduct'.freeze)
					File.readable?(id_vendor_file) && File.readable?(id_vendor_file)
				}
			end

			alias count_devices count

			private
			def hwdata
				@@hwdata_file ||= "/usr/share/hwdata/usb.ids"

				@@hwdata ||= if File.readable?(@@hwdata_file)
					file_data = IO.readlines(@@hwdata_file, encoding: 'ASCII-8BIT')
					ret, vendor_id = {}, nil

					i = -1
					file_data_size = file_data.size

					while (i += 1) < file_data_size
						x = file_data[i]

						_stripped = x.strip
						next if _stripped[0] == ?#.freeze || _stripped[0] == ?\n.freeze

						next if x == ?\n.freeze || x[0] == ?#.freeze

						if x.start_with?(?\t.freeze)
							data = x.tap(&:strip!)
							device_id = data[/\A.*?\s/].to_s.strip
							device = data[device_id.length..-1].to_s.strip
							ret[vendor_id][1][device_id] = device
						else
							data = x
							vendor_id = data[/\A.*?\s/].to_s.strip
							vendor = data[vendor_id.length..-1].to_s.strip
							ret[vendor_id] = [vendor, {}]
						end
					end

					ret.freeze
				else
					[]
				end
			end

			def query_hwdata(vendor_id, product_id)
				vendor = hwdata[vendor_id]
				{vendor: vendor[0], product: vendor[1][product_id]} if vendor
			end
		end
	end
end

p LinuxStat::USB.count
