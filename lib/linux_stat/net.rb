module LinuxStat
	module Net
		class << self
			# Returns the local IP address of the system as a String.
			# If the information isn't available, it will a frozen empty string.
			def ipv4_private
				require 'socket'
				ip = Socket.ip_address_list.find(&:ipv4_private?)
				ip ? ip.ip? ? ip.ip_unpack[0].freeze : ''.freeze : ''.freeze
			end
		end
	end
end
