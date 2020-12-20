module LinuxStat
	module Filesystem
		class << self
			##
			# = stat(fs = '.')
			#
			# Where fs is the directory of the file system (like / or /tmp/ or /run/media/thumbdrive).
			#
			# * It returns a Hash with the following info:
			#
			#   1. total size of the device (in bytes)
			#   2. free space (in kilobytes)
			#   3. used space (in kilobytes)
			#
			# In a hash format:
			#    {:total=>119981191168, :free=>43155574784, :used=>76825616384, :available=>43155574784}
			#
			# If the stat can't be acquired, this method will return an empty Hash.
			def stat(fs = ?..freeze)
				s = stat_raw(fs)
				return {} if s.empty?
				s.default = 0

				{
					total: s[:block_size] * s[:blocks],
					free: s[:block_size] * s[:block_free],
					used: s[:blocks].-(s[:block_free]) * s[:block_size]
				}
			end

			##
			# = total(fs = '.')
			#
			# Where fs is the directory of the file system (like / or /tmp/ or /run/media/thumbdrive).
			#
			# It returns the total size of a given disk in bytes.
			#
			# If the stat can't be acquired, this method will return nil.
			def total(fs = ?..freeze)
				s = stat_raw(fs)
				return nil if s.empty?
				s.default = 0
				s[:block_size] * s[:blocks]
			end

			##
			# = free(fs = '.')
			#
			# Where fs is the directory of the file system (like / or /tmp/ or /run/media/thumbdrive).
			#
			# It returns the total free space in a disk in bytes.
			#
			# It is to be noted that free is not same as available.
			#
			# Free returns the size of free blocks.
			#
			# If the stat can't be acquired, this method will return an empty Hash.
			def free(fs = ?..freeze)
				s = stat_raw(fs)
				return nil if s.empty?
				s.default = 0
				s[:block_size] * s[:block_free]
			end

			##
			# = used(fs = '.')
			#
			# Where fs is the directory of the file system (like / or /tmp/ or /run/media/thumbdrive).
			#
			# It returns the used space of a given disk in bytes.
			#
			# If the stat can't be acquired, this method will return nil.
			def used(fs = ?..freeze)
				s = stat_raw(fs)
				return nil if s.empty?
				s.default = 0
				s[:blocks].-(s[:block_free]) * s[:block_size]
			end

			##
			# = available(fs = '.')
			#
			# Where fs is the directory of the file system (like / or /tmp/ or /run/media/thumbdrive).
			#
			# It returns the total free space in a disk in bytes.
			#
			# It is to be noted that free is not same as available.
			#
			# Available returns the size of free blocks for unpriviledged users.
			#
			# If the stat can't be acquired, this method will return an empty Hash.
			def available(fs = ?..freeze)
				s = stat_raw(fs)
				return nil if s.empty?
				s.default = 0
				s[:block_size] * s[:block_avail_unpriv]
			end

			##
			# = stat_raw(fs = '.')
			#
			# Where fs is the directory of the file system (like / or /tmp/ or /run/media/thumbdrive).
			#
			# It returns a Hash with the following data (for example):
			#    {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>10535967, :block_avail_unpriv=>10535967, :inodes=>58612160, :free_inodes=>56718550, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}
			#
			# If the stat can't be acquired, this method will return an empty Hash.
			def stat_raw(fs = ?..freeze)
				LinuxStat::FS.stat(fs)
			end
		end
	end
end
