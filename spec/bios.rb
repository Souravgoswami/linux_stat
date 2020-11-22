# model vendor version date

RSpec.describe LinuxStat::BIOS do
	it "model returns string" do
		expect(LinuxStat::BIOS.model.class).to be String
	end

	it "vendor returns string" do
		expect(LinuxStat::BIOS.vendor.class).to be String
	end

	it "version returns string" do
		expect(LinuxStat::BIOS.version.class).to be String
	end

	it "date returns string" do
		expect(LinuxStat::BIOS.date.class).to be String
	end
end
