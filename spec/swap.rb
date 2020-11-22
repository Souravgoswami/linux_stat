# available list stat total used

RSpec.describe LinuxStat::Swap do
	it "available returns an Integer" do
		expect(LinuxStat::Swap.available.class).to be Integer
	end

	it "list returns a Hash" do
		expect(LinuxStat::Swap.list.class).to be Hash
	end

	it "stat returns a Hash" do
		expect(LinuxStat::Swap.stat.class).to be Hash
	end

	it "total returns an Integer" do
		expect(LinuxStat::Swap.total.class).to be Integer
	end

	it "used returns an Integer" do
		expect(LinuxStat::Swap.used.class).to be Integer
	end

	it "percent_used returns a Float" do
		expect(LinuxStat::Swap.percent_used.class).to be Float
	end

	it "available returns an Float" do
		expect(LinuxStat::Swap.percent_available.class).to be Float
	end
end
