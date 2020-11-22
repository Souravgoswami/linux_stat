module LinuxStat
	module BIOS
		class << self
			def model
				# Cached ; as changing the value in runtime is unexpected
				@@model ||= if File.readable?('/sys/devices/virtual/dmi/id/product_name')
					IO.read('/sys/devices/virtual/dmi/id/product_name').tap(&:strip!)
				elsif File.readable?('/sys/firmware/devicetree/base/model')
					IO.read('/sys/firmware/devicetree/base/model').tap(&:strip!)
				else
					''.freeze
				end
			end

			def vendor
				# Cached ; as changing the value in runtime is unexpected
				@@vendor ||= if File.readable?('/sys/devices/virtual/dmi/id/bios_vendor')
					IO.read('/sys/devices/virtual/dmi/id/bios_vendor').tap(&:strip!)
				else
					''.freeze
				end
			end

			def version
				# Cached ; as changing the value in runtime is unexpected
				@@version ||= if File.readable?('/sys/devices/virtual/dmi/id/bios_version')
					IO.read('/sys/devices/virtual/dmi/id/bios_version').tap(&:strip!)
				else
					''.freeze
				end
			end

			def date
				# Cached ; as changing the value in runtime is unexpected
				@@date ||= if File.readable?('/sys/devices/virtual/dmi/id/bios_date')
					IO.read('/sys/devices/virtual/dmi/id/bios_date').tap(&:strip!)
				else
					''.freeze
				end
			end
		end
	end
end
