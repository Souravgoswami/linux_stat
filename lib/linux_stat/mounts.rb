module LinuxStat
	module Mounts
		class << self
			# Reads /proc/mounts and returns list of devices.
			#
			# It returns an Array.
			# If the info isn't available or /proc/mounts is not readable, it will return an empty Array.
			def list
				mounts
			end

			# Reads /proc/mounts and returns partition name of the device mounted at /.
			#
			# It returns a String.
			# But if the info isn't available or /proc/mounts is not readable, it will return an empty frozen String.
			def root
				find_root[0].to_s
			end

			# Reads /proc/mounts and returns the file system of the device mounted at /.
			#
			# It returns a String.
			# But if the info isn't available or /proc/mounts is not readable, it will return an empty frozen String.
			def root_fs
				find_root[2].to_s
			end

			# Reads /proc/mounts and returns the options used for mounting /.
			#
			# It returns a String.
			# But if the info isn't available or /proc/mounts is not readable, it will return an empty frozen string.
			def root_mount_options
				find_root[3].to_s
			end

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
		end
	end
end
