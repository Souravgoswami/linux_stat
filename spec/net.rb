# ipv4_private

RSpec.describe LinuxStat do
	it "ipv4_private returns a String" do
		expect(LinuxStat::Net.ipv4_private.class).to be String
	end
end
