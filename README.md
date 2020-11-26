# LinuxStat
![logo](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/logo/logo.jpg)

LinuxStat lets you read status of a Linux system. It can show you cpu stats and usages, memory stats and usages, swap stats and usages, battery usage, bios info,  kernel details, local ip, os details and parse os-release + lsb-release, etc.

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
=> [2000001, 1999996, 1999998, 1999997]

LinuxStat::CPU.max_freq
=> [2000000, 2000000, 2000000, 2000000]

LinuxStat::CPU.model
=> "Intel(R) Core(TM) i3-6006U CPU @ 2.00GHz"

LinuxStat::CPU.stat
=> {0=>30.0, 1=>50.0, 2=>28.57, 3=>16.67, 4=>28.57}

LinuxStat::CPU.total_usage
=> 26.67

LinuxStat::CPU.usage
=> 25.0

LinuxStat::CPU.usages
=> {0=>33.33, 1=>50.0, 2=>28.57, 3=>28.57, 4=>16.67}

```

### LinuxStat::Kernel
```
LinuxStat::Kernel.build_date
=> 2020-10-21 01:11:20 +0000

LinuxStat::Kernel.build_date_string
=> "21 Oct 2020 01:11:20 +0000"

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
=> 405020

LinuxStat::Memory.percent_available
=> 10.56

LinuxStat::Memory.percent_used
=> 89.44

LinuxStat::Memory.stat
=> {:total=>3836264, :used=>3431244, :available=>405020, :percent_used=>89.44, :percent_available=>10.56}

LinuxStat::Memory.total
=> 3836264

LinuxStat::Memory.used
=> 3431244

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
=> {:hour=>40, :minute=>46, :second=>19.75}

```

### LinuxStat::Process
```
LinuxStat::Process.count
=> 223

LinuxStat::Process.idle
=> [3, 4, 6, 9, 12, 23, 30, 37, 39, 49, 102, 103, 104, 106, 107, 108, 109, 110, 117, 118, 120, 122, 131, 134, 140, 152, 153, 166, 168, 170, 171, 174, 180, 181, 182, 183, 184, 185, 187, 224, 272, 320, 327, 328, 2238, 2239, 2240, 2241, 2242, 2243, 89437, 9...

LinuxStat::Process.list
=> [1, 2, 3, 4, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 46, 47, 48, 49, 50, 51, 52, 102, 103, 104, 106, 107, 108, 109, 110, 111, 114, 115, 117, 118, 120, 122, 131, 134,...

LinuxStat::Process.names
=> {1=>"systemd", 2=>"kthreadd", 3=>"rcu_gp", 4=>"rcu_par_gp", 6=>"kworker/0:0H", 9=>"mm_percpu_wq", 10=>"ksoftirqd/0", 11=>"rcuc/0", 12=>"rcu_preempt", 13=>"rcub/0", 14=>"migration/0", 15=>"idle_inject/0", 16=>"cpuhp/0", 17=>"cpuhp/1", 18=>"idle_inject/...

LinuxStat::Process.running
=> [525, 91940, 91971, 91993, 92020, 95119]

LinuxStat::Process.sleeping
=> [1, 2, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 38, 40, 41, 42, 46, 47, 48, 50, 51, 52, 111, 114, 115, 165, 167, 186, 214, 227, 302, 313, 319, 321, 333, 334, 335, 352, 353, 354, 355, 362, 366, 367, 369, 382,...

LinuxStat::Process.types
=> {1=>:sleeping, 2=>:sleeping, 3=>:idle, 4=>:idle, 6=>:idle, 9=>:idle, 10=>:sleeping, 11=>:sleeping, 12=>:idle, 13=>:sleeping, 14=>:sleeping, 15=>:sleeping, 16=>:sleeping, 17=>:sleeping, 18=>:sleeping, 19=>:sleeping, 20=>:sleeping, 21=>:sleeping, 23=>:i...

LinuxStat::Process.zombie
=> []

```

### LinuxStat::Swap
```
LinuxStat::Swap.any?
=> true

LinuxStat::Swap.available
=> 2292252

LinuxStat::Swap.list
=> {"/dev/zram0"=>[:partition, 4194300, 1902048, -2]}

LinuxStat::Swap.percent_available
=> 54.65

LinuxStat::Swap.percent_used
=> 45.35

LinuxStat::Swap.stat
=> {:total=>4194300, :used=>1902048, :available=>2292252, :percent_used=>45.35, :percent_available=>54.65}

LinuxStat::Swap.total
=> 4194300

LinuxStat::Swap.used
=> 1902048

```

## Return Types:
+ In general, if a method returns either a Float or a Integer or a Time, it will return a Float or Time in all cases. But if the status isn't available, it will return nil.

+ If the method returns a Hash / Array, it will return return Hash / Array in all cases. If the status isn't available, it will return an empty Hash / Array.

+ If the method returns a String, it will return return String in all cases. If the status isn't available, it will return an empty *frozen* String.

+ It doesn't have implementation of any Error that gets raised in runtime for the ease of use.

+ If you need to check some stat that returns an integer or float, and you get nil, you know it's not available, so you can work accordingly. But if you need the integer or float value in 0 to whatever format, you can use the .to_i or .to_f method on the object, nil will get converted to number then.

If some error is *raised* it should be reported as a bug.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing
Like other gems, this doesn't have a test like RSpec. We suggest using the bin/linuxstat.rb file on various systems.
If you need to test a specific module, say the CPU, just run it like this:

```
$ ruby bin/linuxstat.rb CPU
```

Or:
```
$ ruby bin/linuxstat.rb cpu
```

That is, the argument passed is not case-sensitive.
But if the argument passed isn't available and outright wrong, it will run all the module methods. For example, you can't do:

```
$ ruby bin/linuxstat.rb upc
```
This is not a valid module and can't be run.

You can run `rake` to test all the modules.
You can also use `rake cpu` to test the CPU module or `rake memory` to test the memory module. But this is case-sensitive.



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Souravgoswami/linux_stat. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Souravgoswami/linux_stat/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LinuxStat project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Souravgoswami/linux_stat/blob/master/CODE_OF_CONDUCT.md).
