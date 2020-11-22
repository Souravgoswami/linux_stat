# total meminfo? available used percent_used percent_available

RSpec.describe LinuxStat::Memory do
	it "total returns an Integer" do
		expect(LinuxStat::Memory.total.class).to be Integer
	end

	it "used returns an Integer" do
		expect(LinuxStat::Memory.used.class).to be Integer
	end

	it "available returns an Integer" do
		expect(LinuxStat::Memory.available.class).to be Integer
	end

	it "percent_used returns a Float" do
		expect(LinuxStat::Memory.percent_used.class).to be Float
	end

	it "available returns an Float" do
		expect(LinuxStat::Memory.percent_available.class).to be Float
	end
end
