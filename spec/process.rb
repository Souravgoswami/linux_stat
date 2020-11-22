# count idle list names running sleeping types zombie

RSpec.describe LinuxStat do
	it "count returns an Integer" do
		expect(LinuxStat::Process.count.class).to be Integer
	end

	it "idle returns an Array" do
		expect(LinuxStat::Process.idle.class).to be Array
	end

	it "list returns an Array of Integers" do
		expect(LinuxStat::Process.list.all? { |x| x.class == Integer }).to be true
	end

	it "names returns Hash" do
		expect(LinuxStat::Process.count.class).to be Integer
	end

	it "running returns an Array of Integers" do
		expect(LinuxStat::Process.running.all? { |x| x.class == Integer }).to be true
	end
	it "sleeping returns an Array of Integers" do
		expect(LinuxStat::Process.sleeping.all? { |x| x.class == Integer }).to be true
	end
	it "types returns a Hash" do
		expect(LinuxStat::Process.types.class).to be Hash
	end
	it "zombies returns an Array of Integers" do
		expect(LinuxStat::Process.zombie.all? { |x| x.class == Integer }).to be true
	end
end
