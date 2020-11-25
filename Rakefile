require "bundler/gem_tasks"
require_relative File.join(__dir__, 'test/linuxstat.rb')

task :default do
	LinuxStat::Test.run
end

task :battery do
	LinuxStat::Test.run :battery
end

task :bios do
	LinuxStat::Test.run :bios
end

task :cpu do
	LinuxStat::Test.run :cpu
end

task :kernel do
	LinuxStat::Test.run :kernel
end

task :memory do
	LinuxStat::Test.run :memory
end

task :net do
	LinuxStat::Test.run :net
end

task :os do
	LinuxStat::Test.run :os
end

task :process do
	LinuxStat::Test.run :process
end

task :swap do
	LinuxStat::Test.run :swap
end

task :version do
	puts LinuxStat::VERSION
end
