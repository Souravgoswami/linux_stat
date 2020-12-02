# LinuxStat
![logo](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/images/logo.jpg)

For reading the HTML version, visit [linux_stat](https://souravgoswami.github.io/linux_stat/).

LinuxStat lets you read status of a Linux system. It can show you cpu stats and usages, memory stats and usages, swap stats and usages, battery usage, bios info,  kernel details, local ip, os details and parse os-release + lsb-release, etc.

It only works for Linux, and detecting the OS is upto the user of this gem.

## Dependencies:
+ You need to have the C compile to be able to compile the C extension.
On Arch Linux:
```
# pacman -S gcc
```

On Debian based systems:
```
# apt install gcc
```

+ You might also require ruby-dev in Debian based systems which provides support for ruby.h header file:
```
# apt install ruby-dev
```

+ Once your are done, and you can compile the C file, you can follow the installation!

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
=> [1998722, 1998401, 1974377, 1875264]

LinuxStat::CPU.max_freq
=> [2000000, 2000000, 2000000, 2000000]

LinuxStat::CPU.model
=> "Intel(R) Core(TM) i3-6006U CPU @ 2.00GHz"

LinuxStat::CPU.stat
=> {0=>6.45, 1=>0.0, 2=>0.0, 3=>12.5, 4=>0.0}

LinuxStat::CPU.total_usage
=> 3.45

LinuxStat::CPU.usage
=> 6.45

LinuxStat::CPU.usages
=> {0=>9.68, 1=>11.11, 2=>12.5, 3=>14.29, 4=>12.5}

```

### LinuxStat::Filesystem
```
LinuxStat::Filesystem.available
=> 43155402752

LinuxStat::Filesystem.free
=> 43155402752

LinuxStat::Filesystem.stat
=> {:total=>119981191168, :free=>43155402752, :used=>76825788416}

LinuxStat::Filesystem.stat_raw
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>10535987, :block_avail_unpriv=>10535987, :inodes=>58612160, :free_inodes=>56718515, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

LinuxStat::Filesystem.total
=> 119981191168

LinuxStat::Filesystem.used
=> 76825788416

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
=> 403724

LinuxStat::Memory.percent_available
=> 10.52

LinuxStat::Memory.percent_used
=> 89.48

LinuxStat::Memory.stat
=> {:total=>3836264, :used=>3432540, :available=>403724, :percent_used=>89.48, :percent_available=>10.52}

LinuxStat::Memory.total
=> 3836264

LinuxStat::Memory.used
=> 3432540

```

### LinuxStat::Mounts
```
LinuxStat::Mounts.list
=> ["proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0", "sys /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0", "dev /dev devtmpfs rw,nosuid,relatime,size=1891796k,nr_inodes=472949,mode=755 0 0", "run /run tmpfs rw,nosuid,nodev,relatime,mode=755 0 0", "...

LinuxStat::Mounts.root
=> "/dev/sda2"

LinuxStat::Mounts.root_fs
=> "xfs"

LinuxStat::Mounts.root_mount_options
=> "rw,noatime,attr2,inode64,logbufs=8,logbsize=32k,noquota"

LinuxStat::Mounts.tmpfs
=> {"/dev/shm"=>"tmpfs /dev/shm tmpfs rw,nosuid,nodev 0 0", "/sys/fs/cgroup"=>"tmpfs /sys/fs/cgroup tmpfs ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755 0 0", "/ramdisk"=>"tmpfs /ramdisk tmpfs rw,nosuid,nodev,relatime,size=6291456k 0 0", "/tmp...

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
=> {:hour=>10, :minute=>54, :second=>22.45}

```

### LinuxStat::Process
```
LinuxStat::Process.count
=> 210

LinuxStat::Process.idle
=> [3, 4, 6, 9, 12, 23, 30, 37, 39, 49, 102, 103, 104, 106, 107, 108, 109, 110, 117, 118, 119, 122, 131, 134, 140, 152, 153, 179, 181, 183, 184, 191, 192, 193, 194, 195, 196, 198, 236, 286, 314, 324, 346, 385, 3540, 3541, 3542, 3543, 3544, 3545, 30463, 3...

LinuxStat::Process.list
=> [1, 2, 3, 4, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 46, 47, 48, 49, 50, 51, 52, 102, 103, 104, 106, 107, 108, 109, 110, 112, 114, 115, 117, 118, 119, 122, 131, 134,...

LinuxStat::Process.names
=> {1=>"systemd", 2=>"kthreadd", 3=>"rcu_gp", 4=>"rcu_par_gp", 6=>"kworker/0:0H-events_highpri", 9=>"mm_percpu_wq", 10=>"ksoftirqd/0", 11=>"rcuc/0", 12=>"rcu_preempt", 13=>"rcub/0", 14=>"migration/0", 15=>"idle_inject/0", 16=>"cpuhp/0", 17=>"cpuhp/1", 18...

LinuxStat::Process.running
=> [33736]

LinuxStat::Process.sleeping
=> [1, 2, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 38, 40, 41, 42, 46, 47, 48, 50, 51, 52, 112, 114, 115, 178, 180, 197, 225, 239, 309, 317, 329, 332, 333, 334, 338, 367, 368, 369, 370, 378, 381, 383, 384, 402,...

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
=> 1913936

LinuxStat::Swap.list
=> {"/dev/zram0"=>[:partition, 4194300, 2280364, -2]}

LinuxStat::Swap.percent_available
=> 45.63

LinuxStat::Swap.percent_used
=> 54.37

LinuxStat::Swap.stat
=> {:total=>4194300, :used=>2280364, :available=>1913936, :percent_used=>54.37, :percent_available=>45.63}

LinuxStat::Swap.total
=> 4194300

LinuxStat::Swap.used
=> 2280364

```

## Return Types
+ In general, if a method returns either a Float or a Integer or a Time, it will return a Float or Integer or Time in all cases. But if the status isn't available, it will return nil.

+ If the method returns a Hash / Array, it will return return Hash / Array in all cases. If the status isn't available, it will return an empty Hash / Array.

+ If the method returns a String, it will return return String in all cases. If the status isn't available, it will return an empty *frozen* String.

+ It doesn't have implementation of any Error that gets raised in runtime for the ease of use.

+ If you need to check some stat that returns an integer or float, and you get nil, you know it's not available, so you can work accordingly. But if you need the integer or float value in 0 to whatever format, you can use the .to_i or .to_f method on the object, nil will get converted to number then.

If some error is *raised* it should be reported as a bug.

## Ruby on Rails

1. Just add `gem linux_stat`:

```
$ bundle add linux_stat
```

You can use LinuxStat directly in rails.

![RailsApp](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/images/rails.gif)


## Android

LinuxStat does support Android OS. But it's not rigorously tested on all device like android apps.

But in Termux you can just run LinuxStat without facing issues.

![termux](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/images/termux.webp)

Issues regarding running LinuxStat on termux are also welcomed.

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Souravgoswami/linux_stat.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
