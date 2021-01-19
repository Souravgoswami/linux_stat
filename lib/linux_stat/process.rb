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
			# Returns all the id of processes mapped with their names as a Hash.
			def names
				h, i = {}, -1

				l = list
				count = l.length

				while(i += 1) < count
					x = l[i]

					begin
						h.merge!( x => IO.foreach("/proc/#{x}/status").first.split[1..-1].join(?\s.freeze))
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
							case IO.read("/proc/#{x}/stat").split(/(\(.*\))/)[-1][/\s.+?/].strip
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
					begin
						IO.read("/proc/#{x}/stat").split(/(\(.*\))/)[-1][/\s.+?/].strip == ?S.freeze
					rescue StandardError
						false
					end
				}
			end

			##
			# Returns all the id of processes that are idle.
			# The return type is an Array of Integers.
			def idle
				list.select { |x|
					begin
						IO.read("/proc/#{x}/stat").split(/(\(.*\))/)[-1][/\s.+?/].strip == ?I.freeze
					rescue StandardError
						false
					end
				}
			end

			##
			# Returns all the id of processes that are zombies.
			# The return type is an Array of Integers.
			def zombie
				list.select { |x|
					begin
						IO.read("/proc/#{x}/stat").split(/(\(.*\))/)[-1][/\s.+?/].strip == ?Z.freeze
					rescue StandardError
						false
					end
				}
			end

			##
			# Returns all the id of processes that are running.
			# The return type is an Array of Integers.
			def running
				list.select { |x|
					begin
						IO.read("/proc/#{x}/stat").split(/(\(.*\))/)[-1][/\s.+?/].strip == ?R.freeze
					rescue StandardError
						false
					end
				}
			end
		end
	end
end
