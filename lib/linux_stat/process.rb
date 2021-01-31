module LinuxStat
	# Shows various information about a process that is either
	# running, sleeping, idle or a zombie.

	module Process
		class << self
			##
			# Returns the list of processes from /proc/.
			#
			# The return type is an Array of Integers.
			def list
				d = Dir['/proc/*'.freeze]
				ret, i = [], -1
				count = d.length

				while(i += 1) < count
					pid = File.split(d[i])[1]
					pid_i = pid.to_i
					ret << pid_i if pid_i.to_s == pid
				end

				ret
			end

			##
			# Counts and returns the total number of process running on the system.
			#
			# The return type is Integer.
			def count
				list.length
			end

			##
			# Returns all the id of processes mapped with their executable names (comm) as a Hash.
			# The names can be truncated to TASK_COMM_LEN or (16 - 1 = 15) places.
			def names
				h, i = {}, -1

				l = list
				count = l.length

				while(i += 1) < count
					x = l[i]

					begin
						h.merge!( x => IO.read("/proc/#{x}/comm").strip)
					rescue StandardError
					end
				end
				h
			end

			##
			# Returns all the id of processes mapped with their cmdline info as a Hash.
			# The cmdlines aren't usually truncated like names, but they can contain
			# arguments with the command.
			def cmdlines
				h, i = {}, -1

				l = list
				count = l.length

				while(i += 1) < count
					x = l[i]

					begin
						cmdlines = IO.read("/proc/#{x}/cmdline").strip
						cmdlines.gsub!(?\u0000.freeze, ?\s.freeze)
						h.merge!( x => cmdlines)
					rescue StandardError
					end
				end
				h
			end

			##
			# Returns all the id of processes mapped with their status as a Hash.
			def types
				h, i = {}, -1

				l = list
				count = l.length

				while(i += 1) < count
					x = l[i]

					begin
						h.merge!(x =>
							case LinuxStat::ProcFS.ps_state(x)
								when ?S.freeze then :sleeping
								when ?I.freeze then :idle
								when ?Z.freeze then :zombie
								when ?R.freeze then :running
								when ?T.freeze then :stopped
								when ?X.freeze then :dead
								when ?D.freeze then :sleeping
								when ?t.freeze then :stopped
								else :unknown
							end
						)
					rescue StandardError
					end
				end

				h
			end

			##
			# Returns all the id of processes that are sleeping.
			# The return type is an Array of Integers.
			def sleeping
				list.select { |x|
					LinuxStat::ProcFS.ps_state(x) == ?S.freeze
				}
			end

			##
			# Returns all the id of processes that are idle.
			# The return type is an Array of Integers.
			def idle
				list.select { |x|
					LinuxStat::ProcFS.ps_state(x) == ?I.freeze
				}
			end

			##
			# Returns all the id of processes that are zombies.
			# The return type is an Array of Integers.
			def zombie
				list.select { |x|
					LinuxStat::ProcFS.ps_state(x) == ?Z.freeze
				}
			end

			##
			# Returns all the id of processes that are running.
			# The return type is an Array of Integers.
			def running
				list.select { |x|
					LinuxStat::ProcFS.ps_state(x) == ?R.freeze
				}
			end

			##
			# Returns all the id of processes that are stopped.
			# The return type is an Array of Integers.
			def stopped
				list.select { |x|
					v = LinuxStat::ProcFS.ps_state(x)
					v == ?T.freeze || v == ?t.freeze
				}
			end

			##
			# Returns the last_pid of the system.
			# It directly calls LS::ProcFS.last_pid
			#
			# The return value is Integer, but if the status
			# isn't available, it will return nil
			def last_pid
				LinuxStat::ProcFS.last_pid
			end
		end
	end
end
