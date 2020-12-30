module LinuxStat
	# Shows various Net related information of the current system.

	module Net
		class << self
			DEV = '/proc/net/dev'.freeze

			##
			# Returns the local IP address of the system as a String.
			#
			# If the information isn't available, it will a frozen empty string.
			def ipv4_private
				require 'socket' unless defined?(Socket)
				ip = Socket.ip_address_list.find(&:ipv4_private?)
				ip ? ip.ip? ? ip.ip_unpack[0].freeze : ''.freeze : ''.freeze
			end

			##
			# Returns the total bytes received and transmitted as Hash.
			#
			# For example:
			#    LinuxStat::Net.usage
			#
			#    => {:received=>56602867, :transmitted=>6940922}
			#
			# But if the status isn't available it will return an empty Hash.
			def total_bytes
				return {} unless File.readable?(DEV)

				data = IO.readlines(DEV).drop(2)
				indices = find_index_of_bytes
				data.reject! { |x| x.strip.start_with?('lo:') }
				r, t = data.map { |x| x.split.values_at(*indices).map(&:to_i) }.transpose.map(&:sum)

				{
					received: r,
					transmitted: t
				}
			end

			##
			# Returns the total bytes received as Integer.
			#
			# But if the status isn't available it will return nil.
			def total_bytes_received
				return nil unless File.readable?(DEV)

				data = IO.readlines(DEV).drop(2)
				index = find_index_of_bytes[0]
				data.reject! { |x| x.strip.start_with?('lo:') }
				data.map { |x| x.split[index].to_i }.sum
			end

			##
			# Returns the total bytes transmitted as Integer.
			#
			# But if the status isn't available it will return nil.
			def total_bytes_transmitted
				return nil unless File.readable?(DEV)

				data = IO.readlines(DEV).drop(2)
				index = find_index_of_bytes[-1]
				data.reject! { |x| x.strip.start_with?('lo:') }
				data.map { |x| x.split[index].to_i }.sum
			end

			##
			# usage(interval = 0.1)
			#
			# Where interval is the time between polling in seconds. The default is 0.1 seconds.
			#
			# The return type is a Hash, containg the current internet usage (received, transmit) in B/s.
			#
			# For example:
			#    LinuxStat::Net.usage
			#
			#    => {:received=>436060.0, :transmitted=>50350.0}
			#
			# If the system transmits 100 kb in the interval,
			#
			# this method will return 1000 kb/s. That is, it estimates
			#
			# the data it will transmit in one second. Thus, a good and reliable interval is 1 second
			#
			# It will return an empty Hash if the info (/proc/net/dev) isn't available.
			def usage(interval = 0.1)
				return {} unless File.readable?(DEV)

				data = IO.readlines(DEV).drop(2)
				indices = find_index_of_bytes
				data.reject! { |x| x.strip.start_with?('lo:'.freeze) }
				r, t = data.map { |x| x.split.values_at(*indices).map(&:to_i) }.transpose.map(&:sum)

				sleep(interval)

				data2 = IO.readlines(DEV).drop(2)
				data2.reject! { |x| x.strip.start_with?('lo:'.freeze) }
				r2, t2 = data2.map { |x| x.split.values_at(*indices).map(&:to_i) }.transpose.map(&:sum)

				# Measure the difference
				dr, dt = r2.-(r).fdiv(interval), t2.-(t).fdiv(interval)

				{
					received: dr,
					transmitted: dt
				}
			end

			alias current_usage usage

			private
			# Returns the index containing the received and transmitted bytes
			def find_index_of_bytes
				@@index_of_bytes ||= nil

				unless @@index_of_bytes
					data = IO.foreach(DEV)

					r, h = data.next.split, {}

					r.each_with_index { |x, i|
						downcased = x.downcase
						h.merge!(:r => i) if downcased.start_with?('receive'.freeze)
						h.merge!(:t => i) if downcased.start_with?('transmit'.freeze)
					}

					data_0 = data.next.gsub(?|.freeze, ' %'.freeze)
					@@index_of_bytes = []
					data_0.split.each_with_index { |x, i| @@index_of_bytes << i if x == '%bytes'.freeze }
					h[:r] > h[:t] ? @@index_of_bytes.reverse : @@index_of_bytes
				else
					@@index_of_bytes
				end
			end
		end
	end
end
