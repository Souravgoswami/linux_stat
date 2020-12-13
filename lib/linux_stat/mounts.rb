module LinuxStat
	module Mounts
		class << self
			##
			# Reads /proc/mounts and returns the output splitted with \n.
			#
			# In other words, it's same as running IO.readlines('/proc/mounts').each(&:strip!)
			#
			# It returns an Array.
			# If the info isn't available or /proc/mounts is not readable, it will return an empty Array.
			def list
				mounts
			end

			##
			# Reads /proc/mounts and returns list of devices.
			#
			# It returns an Array.
			# If the info isn't available or /proc/mounts is not readable, it will return an empty Array.
			def list_devices
				mounts.map { |x| x.split(?\s.freeze).first }
			end

			##
			# Reads /proc/mounts and returns partition name of the device mounted at /.
			#
			# It returns a String.
			# But if the info isn't available or /proc/mounts is not readable, it will return an empty frozen String.
			def root
				find_root[0].to_s
			end

			##
			# Reads /proc/mounts and returns the file system of the device mounted at /.
			#
			# It returns a String.
			# But if the info isn't available or /proc/mounts is not readable, it will return an empty frozen String.
			def root_fs
				find_root[2].to_s
			end

			##
			# Reads /proc/mounts and returns the options used for mounting /.
			#
			# It returns a String.
			# But if the info isn't available or /proc/mounts is not readable, it will return an empty frozen string.
			def root_mount_options
				find_root[3].to_s
			end

			##
			# Reads /proc/mounts and finds all tmpfs.
			#
			# It returns a Hash
			# But if the info isn't available or /proc/mounts is not readable, it will return an empty Hash.
			def tmpfs
				ret = {}
				mounts.each { |x|
					ret.merge!({x.split[1] => x}) if x.start_with?('tmpfs '.freeze)
				}
				ret
			end

			##
			# mount_point(dev = root)
			#
			# Where device = block device.
			#
			# The default argument is the root block device.
			#
			# It helps you find the mountpoint of a block device.
			# For example:
			#
			#    LinuxStat::Mounts.mount_point('/dev/sdb1')
			#
			#    => "/run/media/sourav/5c2b7af7-d4c3-4ab4-a035-06d18ffc8e6f"
			#
			# The return type is String.
			# But if the status isn't available or the device isn't mounted, it will return an empty String.
			def mount_point(dev = root)
				m = ''
				mounts.each do |x|
					x.strip!

					unless x.empty?
						_x = x.split
						if _x[0] == dev
							m.replace(_x[1])
							break
						end
					end
				end
				m
			end

			##
			# list_devices_mount_point()
			#
			# It shows all the block devices corresponding to mount points.
			#
			# For example:
			#
			#    LinuxStat::Mounts.list_devices_mount_point
			#
			#    => {"proc"=>"/proc", "sys"=>"/sys", "dev"=>"/dev", "run"=>"/run", "/dev/sda2"=>"/", "securityfs"=>"/sys/kernel/security", "tmpfs"=>"/run/user/1000", "devpts"=>"/dev/pts", "cgroup2"=>"/sys/fs/cgroup/unified", "cgroup"=>"/sys/fs/cgroup/perf_event", "pstore"=>"/sys/fs/pstore", "none"=>"/sys/fs/bpf", "systemd-1"=>"/proc/sys/fs/binfmt_misc", "debugfs"=>"/sys/kernel/debug", "mqueue"=>"/dev/mqueue", "hugetlbfs"=>"/dev/hugepages", "tracefs"=>"/sys/kernel/tracing", "configfs"=>"/sys/kernel/config", "fusectl"=>"/sys/fs/fuse/connections", "gvfsd-fuse"=>"/run/user/1000/gvfs", "/dev/sdb1"=>"/run/media/sourav/5c2b7af7-d4c3-4ab4-a035-06d18ffc8e6f", "binfmt_misc"=>"/proc/sys/fs/binfmt_misc"}
			#
			# The return type is Hash.
			# But if the status isn't available or the device isn't mounted, it will return an empty String.
			def list_devices_mount_point
				m = {}
				mounts.each do |x|
					x.strip!

					unless x.empty?
						_x = x.split
						m.merge!(_x[0] => _x[1])
					end
				end
				m
			end

			##
			# devices_stat
			#
			# [ Not to confuse this method with device_stat(dev) which shows only one device's info ]
			#
			# It shows all the block devices corresponding to mount points and data from LinuxStat::FS.stat(arg)
			#
			# For example:
			#
			#    LinuxStat::Mounts.devices_stat
			#
			#    => {"proc"=>{:mountpoint=>"/proc", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_free=>NaN, :percent_available=>NaN}, "/dev/sdb1"=>{:mountpoint=>"/run/media/sourav/5c2b7af7-d4c3-4ab4-a035-06d18ffc8e6f", :total=>31466008576, :free=>2693931008, :available=>2693931008, :used=>28772077568, :percent_used=>91.44, :percent_free=>8.56, :percent_available=>8.56}}
			#
			# The return type is Hash.
			# But if the status isn't available, it will return an empty Hash.
			def devices_stat
				# Code duplication is fine if it gives maximum performance
				m = {}
				mounts.each do |x|
					x.strip!

					unless x.empty?
						_x = x.split
						total, free, available, used = fs_info(_x[1])

						m.merge!(_x[0] => {
							mountpoint: _x[1],

							total: total,
							free: free,
							available: available,
							used: used,

							percent_used: used.*(100).fdiv(total).round(2),
							percent_free: free.*(100).fdiv(total).round(2),
							percent_available: available.*(100).fdiv(total).round(2),
						})
					end
				end
				m
			end

			##
			# device_stat(dev = root)
			#
			# [ Not to confuse this method with devices_stat() which shows all devices ]
			#
			# It shows all the block devices corresponding to mount points and data from LinuxStat::FS.stat(arg)
			#
			# For example:
			#
			#    LinuxStat::Mounts.device_stat('/dev/sda2')
			#
			#    => {"/dev/sda2"=>{:mountpoint=>"/", :total=>119981191168, :free=>35298562048, :available=>35298562048, :used=>84682629120, :percent_used=>70.58, :percent_free=>29.42, :percent_available=>29.42}}
			#
			# The return type is Hash.
			# But if the status isn't available, it will return an empty Hash.
			def device_stat(dev = root)
				# Code duplication is fine if it gives maximum performance
				m = {}
				mounts.each do |x|
					x.strip!

					unless x.empty?
						_x = x.split
						next if _x[0] != dev

						total, free, available, used = fs_info(_x[1])

						m.merge!({
							mountpoint: _x[1],

							total: total,
							free: free,
							available: available,
							used: used,

							percent_used: used.*(100).fdiv(total).round(2),
							percent_free: free.*(100).fdiv(total).round(2),
							percent_available: available.*(100).fdiv(total).round(2),
						})

						break
					end
				end
				m
			end

			private
			def mount_readable?
				@@mount_readable ||= File.readable?('/proc/mounts')
			end

			def mounts
				return [] unless mount_readable?
				IO.readlines('/proc/mounts').each(&:strip!)
			end

			def find_root
				return [] unless mount_readable?
				@@root ||= IO.foreach('/proc/mounts').find { |x| x.split[1] == '/'.freeze }.split
			end

			def fs_info(dev)
				# => [total, free, available, used]
				s = LinuxStat::FS.stat(dev)
				s.default = 0

				[
					s[:block_size] * s[:blocks],
					s[:block_size] * s[:block_free],
					s[:block_size] * s[:block_avail_unpriv],
					s[:blocks].-(s[:block_free]) * s[:block_size]
				]
			end
		end
	end
end
