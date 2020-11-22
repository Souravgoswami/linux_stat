# ipv4_private

RSpec.describe LinuxStat::Net do
	it "ipv4_private returns a String" do
		expect(LinuxStat::Net.ipv4_private.class).to be String
	end
end
