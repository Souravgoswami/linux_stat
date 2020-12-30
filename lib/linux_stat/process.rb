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
						h.merge!( x => IO.foreach("/proc/#{x}/status").first.split[1])
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
							case IO.foreach("/proc/#{x}/stat", ' '.freeze).first(3)[-1][0]
								when ?S.freeze then :sleeping
								when ?I.freeze then :idle
								when ?Z.freeze then :zombie
								when ?R.freeze then :running
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
						IO.foreach("/proc/#{x}/stat", ' '.freeze).first(3)[-1][0] == ?S.freeze
					rescue StandardError
						nil
					end
				}
			end

			##
			# Returns all the id of processes that are idle.
			# The return type is an Array of Integers.
			def idle
				list.select { |x|
					begin
						IO.foreach("/proc/#{x}/stat", ' '.freeze).first(3)[-1][0] == ?I.freeze
					rescue StandardError
						nil
					end
				}
			end

			##
			# Returns all the id of processes that are zombies.
			# The return type is an Array of Integers.
			def zombie
				list.select { |x|
					begin
						IO.foreach("/proc/#{x}/stat", ' '.freeze).first(3)[-1][0] == ?Z.freeze
					rescue StandardError
						nil
					end
				}
			end

			##
			# Returns all the id of processes that are running.
			# The return type is an Array of Integers.
			def running
				list.select { |x|
					begin
						IO.foreach("/proc/#{x}/stat", ' '.freeze).first(3)[-1][0] == ?R.freeze
					rescue StandardError
						nil
					end
				}
			end
		end
	end
end
