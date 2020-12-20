module LinuxStat
	module Process
		class << self
			##
			# Returns the list of processes from /proc/.
			#
			# The return type is an Array of Integers.
			def list
				Dir['/proc/*'].select { |x|
					pid = File.split(x)[1]
					pid.to_i.to_s == pid
				}.map! { |x| File.split(x)[-1].to_i }
			end

			##
			# Counts and returns the total number of process running on the system.
			#
			# The return type is Integer.
			def count
				list.count
			end

			##
			# Returns all the id of processes mapped with their names as a Hash.
			def names
				list.reduce({}) { |h, x|
					begin
						h.merge!( x => IO.foreach(File.join('/proc', x.to_s, 'status')).first.split[1] )
					rescue Exception
						h
					end
				}
			end

			##
			# Returns all the id of processes mapped with their status as a Hash.
			def types
				list.reduce({}) { |h, x|
					begin
						h.merge!(x =>
							case IO.read(File.join('/proc', x.to_s, 'stat')).split[2]
								when ?S.freeze then :sleeping
								when ?I.freeze then :idle
								when ?Z.freeze then :zombie
								when ?R.freeze then :running
								else :unknown
							end
						)
					rescue Exception
						h
					end
				}
			end

			##
			# Returns all the id of processes that are sleeping.
			# The return type is an Array of Integers.
			def sleeping
				list.select { |x|
					begin
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?S
					rescue Exception
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
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?I
					rescue Exception
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
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?Z
					rescue Exception
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
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?R
					rescue Exception
						nil
					end
				}
			end
		end
	end
end
