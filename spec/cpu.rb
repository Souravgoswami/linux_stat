# count cpuinfo cur_freq max_freq model stat stat?

RSpec.describe LinuxStat::CPU do
	it "Expect count method to return Integer" do
		expect(LinuxStat::CPU.count.class).to be Integer
	end

	it "Expect cur_freq method to return Array" do
		expect(LinuxStat::CPU.cur_freq.class).to be Array
	end

	it "Expect max_freq method to return Array" do
		expect(LinuxStat::CPU.max_freq.class).to be Array
	end

	it "Expect model method to return String" do
		expect(LinuxStat::CPU.model.class).to be String
	end

	it "Expect stat method to return Hash" do
		expect(LinuxStat::CPU.stat.class).to be Hash
	end
end
