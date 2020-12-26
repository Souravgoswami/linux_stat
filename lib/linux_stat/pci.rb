module LinuxStat
	module PCI
		class << self
			##
			# = devices_stat(hwdata: true)
			#
			# Returns details about the devices found in /sys/bus/pci/devices/
			#
			# The return value is an Array of multiple Hashes. If there's no info available,
			# it will rather return an empty Array.
			#
			# On Android Termux for example, it can not list the directories because they are
			# not readable the the regular user.
			#
			# It can have information like:
			#
			# path, id, vendor, device, subvendor, sub_device,
			# kernel_driver, revision, irq, enable, hwdata.
			#
			# An example of the returned sample from a test machine is:
			#    LinuxStat::PCI.devices_stat
			#
			#    => [{:path=>"/sys/bus/pci/devices/0000:00:00.0/", :id=>"8086:1904", :vendor=>"8086", :device=>"1904", :sub_vendor=>"1028", :sub_device=>"077d", :kernel_driver=>"skl_uncore", :revision=>"0x08", :irq=>0, :enable=>false, :hwdata=>{:vendor=>"Intel Corporation", :product=>"Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers", :sub_system=>nil}}
			#
			# Right, it's an Array of Hashes.
			#
			# It also takes one option. The hwdata, which is true by default.
			#
			# Information about usb devices is found inside /usr/share/hwdata/pci.ids
			#
			# The data contains the vendor and the product, the subvendor and the subproduct.
			#
			# If the option is enabled, it will try read /usr/share/hwdata/pci.ids
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
			# Also note that if there's no info available or no PCI enabled devices, it will return an empty
			# Hash.
			def devices_stat(hwdata: true)
				@@sys_pci_readable ||= File.readable?('/sys/bus/pci/devices/')
				return [] unless @@sys_pci_readable

				Dir['/sys/bus/pci/devices/*/'.freeze].sort!.map! { |x|
					_vendor_file = File.join(x, 'vendor'.freeze)
					next unless File.readable?(_vendor_file)
					vendor = IO.read(_vendor_file).to_i(16).to_s(16)
					prepend_0(vendor)

					_device_file = File.join(x, 'device'.freeze)
					next unless File.readable?(_device_file)
					device = IO.read(_device_file).to_i(16).to_s(16)
					prepend_0(device)

					_sub_vendor_file = File.join(x, 'subsystem_vendor'.freeze)
					sub_vendor = File.readable?(_sub_vendor_file) ? IO.read(_sub_vendor_file).to_i(16).to_s(16) : nil
					prepend_0(sub_vendor) if sub_vendor

					_sub_device_file = File.join(x, 'subsystem_device'.freeze)
					sub_device = File.readable?(_sub_device_file) ? IO.read(_sub_device_file).to_i(16).to_s(16) : nil
					prepend_0(sub_device) if sub_device

					_uevent = File.join(x, 'uevent'.freeze)
					uevent = File.readable?(_uevent) ? IO.foreach(_uevent) : nil

					kernel_driver = if uevent
						uevent.find { |x|
							x.split(?=.freeze)[0].to_s.tap(&:strip!) == 'DRIVER'.freeze
						} &.split(?=) &.[](1) &.tap(&:strip!)
					else
						nil
					end

					_revision_file = File.join(x, 'revision'.freeze)
					revision = File.readable?(_revision_file) ? IO.read(_revision_file).tap(&:strip!) : ''.freeze

					_irq_file = File.join(x, 'irq'.freeze)
					irq = File.readable?(_irq_file) ? IO.read(_irq_file).to_i : nil

					_enable_file = File.join(x, 'enable'.freeze)
					enable = File.readable?(_enable_file) ? IO.read(_enable_file).to_i  == 1 : nil

					query = if hwdata && sub_vendor && sub_device
						query_hwdata(vendor, device, sub_vendor, sub_device)
					elsif hwdata && sub_vendor
						query_hwdata(vendor, device, sub_vendor)
					elsif hwdata
						query_hwdata(vendor, device)
					else
						{}
					end

					ret = {
						path: x, id: "#{vendor}:#{device}",
						vendor: vendor, device: device
					}

					ret.merge!(sub_vendor: sub_vendor) if sub_vendor
					ret.merge!(sub_device: sub_device) if sub_device

					ret.merge!(kernel_driver: kernel_driver) if kernel_driver
					ret.merge!(revision: revision) unless revision.empty?
					ret.merge!(irq: irq) if irq
					ret.merge!(enable: enable) unless enable.nil?
					ret.merge!(hwdata: query) unless query.empty?

					ret
				}
			end

			##
			# Opens /sys/bus/pci/devices, and counts the total number of
			# devices connected to the PCI.
			# The return type is an integer.
			#
			# It checks for devices with vendor and device id files.
			# If there's no such file, it will not count them as a PCI connected device.
			#
			# But if the information isn't available, it will return nil.
			def count
				@@sys_pci_readable ||= File.readable?('/sys/bus/pci/devices/')
				return nil unless @@sys_pci_readable

				Dir['/sys/bus/pci/devices/*/'.freeze].count { |x|
					id_vendor_file = File.join(x, 'vendor'.freeze)
					id_product_file = File.join(x, 'device'.freeze)
					File.readable?(id_vendor_file) && File.readable?(id_product_file)
				}
			end

			alias count_devices count

			private
			def hwdata
				@@hwdata_file ||= "/usr/share/hwdata/pci.ids"

				@@hwdata ||= if File.readable?(@@hwdata_file)
					ret, vendor_id, device_id, device = {}, nil, nil, nil
					i = -1

					file_data = IO.readlines(@@hwdata_file, encoding: 'ASCII-8BIT')
					file_data_size = file_data.size

					while (i += 1) < file_data_size
						x = file_data[i]

						_lstripped = x.lstrip
						next if _lstripped[0] == ?#.freeze || _lstripped.empty?

						if x[0..1] == "\t\t".freeze
							next unless device_id

							x.strip!
							sub_device_id = x[/\A.*?\s/].to_s.strip
							sub_device = x[device_id.length..-1].to_s.strip

							if ret[vendor_id] &.at(1) &.[](device_id) &.[](1)
								sub_system_id = sub_device[/\A.*?\s/].to_s.strip
								sub_system_device = sub_device[sub_system_id.length..-1].to_s.strip

								ret[vendor_id][1][device_id][1].merge!(sub_device_id => {sub_system_id => sub_system_device})
							end

						elsif x[0] == ?\t.freeze
							next unless vendor_id

							x.strip!
							device_id = x[/\A.*?\s/].to_s.strip
							device = x[device_id.length..-1].to_s.strip
							ret[vendor_id][1][device_id] = [device, {}]

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

			def prepend_0(n)
				n[0, 0] = ?0.*(4 - n.length).freeze if n.length < 4
				n
			end

			def query_hwdata(vendor_id, product_id, sub_vendor_id = nil, sub_device_id = nil)
				vendor = hwdata[vendor_id]

				if vendor
					ret = {
						vendor: vendor[0],
						product: vendor.dig(1, product_id, 0),
					}

					if sub_vendor_id && sub_device_id
						sub_product = vendor.dig(1, product_id, 1, sub_vendor_id, sub_device_id)
						ret.merge!(sub_system: sub_product)
					end

					ret
 				else
					{}
				end
			end
		end
	end
end
