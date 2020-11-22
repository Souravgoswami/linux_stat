RSpec.describe LinuxStat do
	it "lsb_release returns a Hash" do
		expect(LinuxStat::OS.lsb_release.class).to be Hash
	end

	it "os_release returns a Hash" do
		expect(LinuxStat::OS.os_release.class).to be Hash
	end

	it "uptime returns a Hash | raises Error when file not available" do
		if File.readable?('/proc/uptime')
			expect(LinuxStat::OS.uptime.class).to be Hash
		else
			expect { LinuxStat::OS.uptime }.to raise_error(LinuxStat::StatUnavailable)
		end
	end
end
