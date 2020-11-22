# build_date compiler string version

RSpec.describe LinuxStat::Kernel do
	it "build_date returns a Time object" do
		expect(LinuxStat::Kernel.build_date.class).to be Time
	end

	it "compiler returns an Array" do
		expect(LinuxStat::Kernel.compiler.class).to be Array
	end

	it "string returns a String" do
		expect(LinuxStat::Kernel.string.class).to be String
	end

	it "version returns an String" do
		expect(LinuxStat::Kernel.version.class).to be String
	end
end
