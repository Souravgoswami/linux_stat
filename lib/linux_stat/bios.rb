module LinuxStat
	module BIOS
		class << self
			##
			# Returns the model of the BIOS.
			#
			# If the information is not available it will return a frozen empty string.
			#
			# The output is also cached (memoized) ; as changing the value in runtime is unexpected.
			def model
				# cached (memoized) ; as changing the value in runtime is unexpected
				@@model ||= if File.readable?('/sys/devices/virtual/dmi/id/product_name')
					IO.read('/sys/devices/virtual/dmi/id/product_name').tap(&:strip!)
				elsif File.readable?('/sys/firmware/devicetree/base/model')
					IO.read('/sys/firmware/devicetree/base/model').tap(&:strip!)
				else
					''.freeze
				end
			end

			##
			# Returns the vendor of the BIOS.
			#
			# If the information is not available it will return a frozen empty string.
			#
			# The output is also cached (memoized) ; as changing the value in runtime is unexpected.
			def vendor
				# cached (memoized) ; as changing the value in runtime is unexpected
				@@vendor ||= if File.readable?('/sys/devices/virtual/dmi/id/bios_vendor')
					IO.read('/sys/devices/virtual/dmi/id/bios_vendor').tap(&:strip!)
				else
					''.freeze
				end
			end

			##
			# Returns the version of the BIOS.
			#
			# If the information is not available it will return a frozen empty string.
			#
			# The output is also cached (memoized) ; as changing the value in runtime is unexpected.
			def version
				@@version ||= if File.readable?('/sys/devices/virtual/dmi/id/bios_version')
					IO.read('/sys/devices/virtual/dmi/id/bios_version').tap(&:strip!)
				else
					''.freeze
				end
			end

			##
			# Returns the date of the BIOS.
			#
			# If the information is not available it will return a frozen empty string.
			#
			# The output is also cached (memoized) ; as changing the value in runtime is unexpected.
			def date
				@@date ||= if File.readable?('/sys/devices/virtual/dmi/id/bios_date')
					IO.read('/sys/devices/virtual/dmi/id/bios_date').tap(&:strip!)
				else
					''.freeze
				end
			end
		end
	end
end
