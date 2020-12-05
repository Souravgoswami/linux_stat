require_relative 'lib/linux_stat/version'

Gem::Specification.new do |s|
	s.name = "linux_stat"
	s.version = LinuxStat::VERSION
	s.authors = ["Sourav Goswami"]
	s.email   = %w(souravgoswami@protonmail.com)
	s.summary = %q(Efficient linux system reporting gem)
	s.description = %q(Linux only, efficient linux system utilization reporting and system monitoring gem)
	s.homepage = "https://github.com/Souravgoswami/linux_stat/"
	s.license = "MIT"
	s.required_ruby_version = Gem::Requirement.new(">= 2.5.0")
	s.files = Dir.glob(%w(lib/**/*.rb ext/**/*.{c,rb} bin/** README.md LICENSE.txt))
	s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
	s.extensions = Dir.glob("ext/**/extconf.rb")
	s.require_paths = ["lib"]
	s.extra_rdoc_files = Dir.glob(%w(README.md))
	s.bindir = "bin"
end
