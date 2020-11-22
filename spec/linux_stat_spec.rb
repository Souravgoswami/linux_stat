RSpec.describe LinuxStat do
	it "has a version number" do
		expect(LinuxStat::VERSION).not_to be nil
	end
end

require_relative File.join(__dir__, 'battery')
require_relative File.join(__dir__, 'bios')
require_relative File.join(__dir__, 'cpu')
require_relative File.join(__dir__, 'kernel')
require_relative File.join(__dir__, 'memory')
require_relative File.join(__dir__, 'net')
require_relative File.join(__dir__, 'os')
require_relative File.join(__dir__, 'process')
require_relative File.join(__dir__, 'swap')
