# LinuxStat
![logo](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/logo.jpg)

LinuxStat lets you read statistics of a Linux system. It can show you cpu stats and usages, memory stats and usages, swap stats and usages, battery usage, bios info,  kernel details, local ip, os details and parse os-release + lsb-release, etc.

It only works for Linux, and detecting the OS is upto the user of this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'linux_stat'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install linux_stat

## Usage
### LinuxStat::BIOS
```
LinuxStat::BIOS.date
=> "04/10/2017"

LinuxStat::BIOS.model
=> "Inspiron 5567"

LinuxStat::BIOS.vendor
=> "Dell Inc."

LinuxStat::BIOS.version
=> "1.1.2"

```

### LinuxStat::Battery
```
LinuxStat::Battery.charge
=> 100.0

LinuxStat::Battery.charging?
=> true

LinuxStat::Battery.discharging?
=> false

LinuxStat::Battery.full?
=> true

LinuxStat::Battery.manufacturer
=> "Samsung SDI"

LinuxStat::Battery.model
=> "DELL CYMGM77"

LinuxStat::Battery.present?
=> true

LinuxStat::Battery.stat
=> {:model=>"DELL CYMGM77", :manufacturer=>"Samsung SDI", :technology=>"Li-ion", :status=>"Full", :charge=>100.0, :charging=>true, :discharging=>false, :full=>true}

LinuxStat::Battery.status
=> "Full"

LinuxStat::Battery.technology
=> "Li-ion"

```

### LinuxStat::CPU
```
LinuxStat::CPU.count
=> 4

LinuxStat::CPU.cur_freq
=> [1973525, 2000029, 2000168, 2000152]

LinuxStat::CPU.max_freq
=> [2000000, 2000000, 2000000, 2000000]

LinuxStat::CPU.model
=> "Intel(R) Core(TM) i3-6006U CPU @ 2.00GHz"

LinuxStat::CPU.stat
=> {0=>6.45, 1=>12.5, 2=>0.0, 3=>0.0, 4=>12.5}

LinuxStat::CPU.total_usage
=> 6.67

LinuxStat::CPU.usage
=> 0.0

LinuxStat::CPU.usages
=> {0=>9.68, 1=>0.0, 2=>12.5, 3=>0.0, 4=>12.5}

```

### LinuxStat::Kernel
```
LinuxStat::Kernel.build_date
=> 2020-10-21 01:11:20 +0000

LinuxStat::Kernel.build_user
=> "souravgoswami@archlinux"

LinuxStat::Kernel.compiler
=> [:gcc, "10.2.0"]

LinuxStat::Kernel.compiler_version
=> "10.2.0"

LinuxStat::Kernel.string
=> "Linux version 5.9.1-xanmod1-1 (souravgoswami@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP PREEMPT Wed, 21 Oct 2020 01:11:20 +0000"

LinuxStat::Kernel.version
=> "5.9.1-xanmod1-1"

```

### LinuxStat::Memory
```
LinuxStat::Memory.available
=> 496044

LinuxStat::Memory.percent_available
=> 12.93

LinuxStat::Memory.percent_used
=> 87.07

LinuxStat::Memory.stat
=> {:total=>3836264, :used=>3340220, :available=>496044, :percent_used=>87.07, :percent_available=>12.93}

LinuxStat::Memory.total
=> 3836264

LinuxStat::Memory.used
=> 3340220

```

### LinuxStat::Net
```
LinuxStat::Net.ipv4_private
=> "192.168.0.106"

```

### LinuxStat::OS
```
LinuxStat::OS.bits
=> 64

LinuxStat::OS.distribution
=> "Arch Linux"

LinuxStat::OS.hostname
=> "archlinux"

LinuxStat::OS.lsb_release
=> {:LSB_VERSION=>"1.4", :DISTRIB_ID=>"Arch", :DISTRIB_RELEASE=>"rolling", :DISTRIB_DESCRIPTION=>"Arch Linux"}

LinuxStat::OS.os_release
=> {:NAME=>"Arch Linux", :PRETTY_NAME=>"Arch Linux", :ID=>"arch", :BUILD_ID=>"rolling", :ANSI_COLOR=>"38;2;23;147;209", :HOME_URL=>"https://www.archlinux.org/", :DOCUMENTATION_URL=>"https://wiki.archlinux.org/", :SUPPORT_URL=>"https://bbs.archlinux.org/"...

LinuxStat::OS.uptime
=> {:hour=>11, :minute=>33, :second=>52.62}

```

### LinuxStat::Process
```
LinuxStat::Process.count
=> 212

LinuxStat::Process.idle
=> [3, 4, 6, 9, 12, 23, 30, 37, 39, 49, 102, 103, 104, 106, 107, 108, 109, 110, 117, 118, 119, 121, 131, 134, 140, 152, 153, 170, 172, 174, 177, 179, 180, 184, 185, 186, 187, 188, 189, 227, 274, 285, 293, 316, 1918, 1919, 1920, 1921, 1922, 1923, 62565, 6...

LinuxStat::Process.list
=> [1, 2, 3, 4, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 46, 47, 48, 49, 50, 51, 52, 102, 103, 104, 106, 107, 108, 109, 110, 111, 114, 115, 117, 118, 119, 121, 131, 134,...

LinuxStat::Process.names
=> {1=>"systemd", 2=>"kthreadd", 3=>"rcu_gp", 4=>"rcu_par_gp", 6=>"kworker/0:0H", 9=>"mm_percpu_wq", 10=>"ksoftirqd/0", 11=>"rcuc/0", 12=>"rcu_preempt", 13=>"rcub/0", 14=>"migration/0", 15=>"idle_inject/0", 16=>"cpuhp/0", 17=>"cpuhp/1", 18=>"idle_inject/...

LinuxStat::Process.running
=> [64200]

LinuxStat::Process.sleeping
=> [1, 2, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 38, 40, 41, 42, 46, 47, 48, 50, 51, 52, 111, 114, 115, 169, 171, 190, 217, 228, 284, 291, 311, 322, 334, 335, 336, 346, 349, 350, 353, 362, 365, 367, 369, 382,...

LinuxStat::Process.types
=> {1=>:sleeping, 2=>:sleeping, 3=>:idle, 4=>:idle, 6=>:idle, 9=>:idle, 10=>:sleeping, 11=>:sleeping, 12=>:idle, 13=>:sleeping, 14=>:sleeping, 15=>:sleeping, 16=>:sleeping, 17=>:sleeping, 18=>:sleeping, 19=>:sleeping, 20=>:sleeping, 21=>:sleeping, 23=>:i...

LinuxStat::Process.zombie
=> []

```

### LinuxStat::Swap
```
LinuxStat::Swap.available
=> 3142816

LinuxStat::Swap.list
=> {"/dev/zram0"=>[:partition, 4194300, 1051484, -2]}

LinuxStat::Swap.percent_available
=> 74.93

LinuxStat::Swap.percent_used
=> 25.07

LinuxStat::Swap.stat
=> {:total=>4194300, :used=>1051484, :available=>3142816, :percent_used=>25.07, :percent_available=>74.93}

LinuxStat::Swap.total
=> 4194300

LinuxStat::Swap.used
=> 1051484

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/linux_stat. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[Souravgoswami]/linux_stat/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LinuxStat project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/linux_stat/blob/master/CODE_OF_CONDUCT.md).
