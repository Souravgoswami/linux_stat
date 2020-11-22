module LinuxStat
	module Net
		class << self
			def ipv4_private
				require 'socket'
				ip = Socket.ip_address_list.find(&:ipv4_private?)
				ip ? ip.ip? ? ip.ip_unpack[0].freeze : '' : ''
			end
		end
	end
end
