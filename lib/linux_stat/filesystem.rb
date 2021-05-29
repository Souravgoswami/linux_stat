module LinuxStat
	# Shows various Filesystem related information of the current system.

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

			def sector_size(path = LinuxStat::Mounts.root)
				LinuxStat::FS.sectors(path)
			end

			def io_total(path = LinuxStat::Mounts.root)
				p = File.split(path)[-1]
				_io_total = LinuxStat::FS.total_io(p)

				return {} if _io_total.empty?

				sector_size = LinuxStat::FS.sectors(path)
				return {} unless sector_size

				{
					read: _io_total[0] &.*(sector_size),
					write: _io_total[1] &.*(sector_size),
				}
			end

			def io_usage(path = LinuxStat::Mounts.root, interval = 0.1)
				p = File.split(path)[-1]

				measure1 = LinuxStat::FS.total_io(p)
				sleep(interval)
				measure2 = LinuxStat::FS.total_io(p)

				return {} if measure1.empty? || measure2.empty?

				sector_size = LinuxStat::FS.sectors(path)
				return {} unless sector_size

				m1r = measure1[0]
				m1w = measure1[1]

				m2r = measure2[0]
				m2w = measure2[1]

				{
					read: m2r.-(m1r).*(sector_size).fdiv(interval),
					write: m2w.-(m1w).*(sector_size).fdiv(interval)
				}
			end

			alias sectors sector_size
		end
	end
end
