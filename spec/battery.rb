# charge charging? discharging? full? manufacturer model stat status technology

RSpec.describe LinuxStat::Battery do
	it 'charge returns a Float' do
		expect(LinuxStat::Battery.charge.class).to be Float
	end

	it 'charging? returns either "true" or "false"' do
		expect(LinuxStat::Battery.charging?).to be(true).or be(false)
	end

	it 'discharging? returns either "true" or "false"' do
		expect(LinuxStat::Battery.discharging?).to be(true).or be(false)
	end

	it 'full? returns either "true" or "false"' do
		expect(LinuxStat::Battery.full?).to be(true).or be(false)
	end

	it 'manufacturer returns a String' do
		expect(LinuxStat::Battery.manufacturer.class).to be String
	end

	it 'model returns a String' do
		expect(LinuxStat::Battery.model.class).to be String
	end

	it 'stat returns a Hash' do
		expect(LinuxStat::Battery.stat.class).to be Hash
	end

	it 'present? returns either "true" or "false"' do
		expect(LinuxStat::Battery.present?).to be(true).or be(false)
	end

	it 'status returns a String' do
		expect(LinuxStat::Battery.status.class).to be String
	end

	it 'technology returns a String' do
		expect(LinuxStat::Battery.technology.class).to be String
	end
end
