# LinuxStat [![Ruby Gem](https://badge.fury.io/rb/linux_stat.svg)](https://rubygems.org/gems/linux_stat) ![Workflow Status](https://github.com/souravgoswami/linux_stat/workflows/LinuxStat%20Test/badge.svg)

---

![logo](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/images/logo.jpg)

For reading the eyecandy HTML version, visit [linux_stat](https://souravgoswami.github.io/linux_stat/).

LinuxStat lets you read status of a Linux system. It can show you cpu stats and usages, memory stats and usages, swap stats and usages, battery usage, bios info,  kernel details, local ip, os details and parse os-release + lsb-release, etc.

It only works for Linux, and detecting the OS is upto the user of this gem.

Programming Languages Used:

<img src="https://linuxstatloc.herokuapp.com/badge.svg" width="240px">

---

## Dependencies:
+ You need to have the C compiler installed to be able to compile the C extensions.
On Arch Linux:
```
# pacman -S gcc make
```

On Debian based systems:
```
# apt install gcc build-essential
```

+ You might also require ruby-dev in Debian based systems which provides support for ruby.h header file:
```
# apt install ruby-dev
```

+ Once your are done, and you can compile the C file, you can follow the installation!

---

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
# File: bios.rb | Line: 56
# Definition: def date
LinuxStat::BIOS.date()
=> "04/10/2017"

# File: bios.rb | Line: 10
# Definition: def model
LinuxStat::BIOS.model()
=> "Inspiron 5567"

# File: bios.rb | Line: 27
# Definition: def vendor
LinuxStat::BIOS.vendor()
=> "Dell Inc."

# File: bios.rb | Line: 42
# Definition: def version
LinuxStat::BIOS.version()
=> "1.1.2"

```

### LinuxStat::Battery
```
# File: battery.rb | Line: 100
# Definition: def charge
LinuxStat::Battery.charge()
=> 100.0

# File: battery.rb | Line: 73
# Definition: def charging?
LinuxStat::Battery.charging?()
=> true

# File: battery.rb | Line: 82
# Definition: def discharging?
LinuxStat::Battery.discharging?()
=> false

# File: battery.rb | Line: 91
# Definition: def full?
LinuxStat::Battery.full?()
=> true

# File: battery.rb | Line: 45
# Definition: def manufacturer
LinuxStat::Battery.manufacturer()
=> "Samsung SDI"

# File: battery.rb | Line: 36
# Definition: def model
LinuxStat::Battery.model()
=> "DELL CYMGM77"

# File: battery.rb | Line: 8
# Definition: def present?
LinuxStat::Battery.present?()
=> true

# File: battery.rb | Line: 16
# Definition: def stat
LinuxStat::Battery.stat()
=> {:model=>"DELL CYMGM77", :manufacturer=>"Samsung SDI", :technology=>"Li-ion", :status=>"Full", :charge=>100.0, :charging=>true, :discharging=>false, :full=>true}

# File: battery.rb | Line: 64
# Definition: def status
LinuxStat::Battery.status()
=> "Full"

# File: battery.rb | Line: 54
# Definition: def technology
LinuxStat::Battery.technology()
=> "Li-ion"

```

### LinuxStat::CPU
```
# File: cpu.rb | Line: 95
# Definition: def count
LinuxStat::CPU.count()
=> 4

# File: cpu.rb | Line: 116
# Definition: def cur_freq
LinuxStat::CPU.cur_freq()
=> [2000141, 2000023, 1999435, 2000128]

# File: cpu.rb | Line: 131
# Definition: def max_freq
LinuxStat::CPU.max_freq()
=> [2000000, 2000000, 2000000, 2000000]

# File: cpu.rb | Line: 108
# Definition: def model
LinuxStat::CPU.model()
=> "Intel(R) Core(TM) i3-6006U CPU @ 2.00GHz"

# File: cpu.rb | Line: 84
# Definition: def online
LinuxStat::CPU.online()
=> 4

# File: cpu.rb | Line: 21
# Definition: def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.stat(sleep)
=> {0=>5.26, 1=>0.0, 2=>0.0, 3=>0.0, 4=>16.67}

# File: cpu.rb | Line: 63
# Definition: def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.total_usage(sleep)
=> 15.0

# File: cpu.rb | Line: 63
# Definition: def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usage(sleep)
=> 10.0

# File: cpu.rb | Line: 21
# Definition: def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usages(sleep)
=> {0=>15.0, 1=>20.0, 2=>0.0, 3=>20.0, 4=>20.0}

```

### LinuxStat::FS
```
LinuxStat::FS.stat(arg = "/")
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>12798990, :block_avail_unpriv=>12798990, :inodes=>58612160, :free_inodes=>56966374, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

```

### LinuxStat::Filesystem
```
# File: filesystem.rb | Line: 92
# Definition: def available(fs = ?/.freeze)
LinuxStat::Filesystem.available(fs)
=> 52424663040

# File: filesystem.rb | Line: 58
# Definition: def free(fs = ?/.freeze)
LinuxStat::Filesystem.free(fs)
=> 52424663040

# File: filesystem.rb | Line: 19
# Definition: def stat(fs = ?/.freeze)
LinuxStat::Filesystem.stat(fs)
=> {:total=>119981191168, :free=>52424663040, :used=>67556528128}

# File: filesystem.rb | Line: 108
# Definition: def stat_raw(fs = ?/.freeze)
LinuxStat::Filesystem.stat_raw(fs)
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>12798990, :block_avail_unpriv=>12798990, :inodes=>58612160, :free_inodes=>56966374, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

# File: filesystem.rb | Line: 39
# Definition: def total(fs = ?/.freeze)
LinuxStat::Filesystem.total(fs)
=> 119981191168

# File: filesystem.rb | Line: 73
# Definition: def used(fs = ?/.freeze)
LinuxStat::Filesystem.used(fs)
=> 67556528128

```

### LinuxStat::Kernel
```
# File: kernel.rb | Line: 86
# Definition: def build_date
LinuxStat::Kernel.build_date()
=> 2020-11-20 07:44:55 +0000

# File: kernel.rb | Line: 140
# Definition: def build_date_string
LinuxStat::Kernel.build_date_string()
=> "20 Nov 2020 07:44:55 +0000"

# File: kernel.rb | Line: 21
# Definition: def build_user
LinuxStat::Kernel.build_user()
=> "souravgoswami@archlinux"

# File: kernel.rb | Line: 179
# Definition: def ticks
LinuxStat::Kernel.clk_tck()
=> 100

# File: kernel.rb | Line: 33
# Definition: def compiler
LinuxStat::Kernel.compiler()
=> [:gcc, "10.2.0"]

# File: kernel.rb | Line: 55
# Definition: def compiler_version
LinuxStat::Kernel.compiler_version()
=> "10.2.0"

# File: kernel.rb | Line: 10
# Definition: def version
LinuxStat::Kernel.release()
=> "5.9.9-xanmod1-1"

# File: kernel.rb | Line: 169
# Definition: def string
LinuxStat::Kernel.string()
=> "Linux version 5.9.9-xanmod1-1 (souravgoswami@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP PREEMPT Fri, 20 Nov 2020 07:44:55 +0000"

# File: kernel.rb | Line: 179
# Definition: def ticks
LinuxStat::Kernel.ticks()
=> 100

# File: kernel.rb | Line: 10
# Definition: def version
LinuxStat::Kernel.version()
=> "5.9.9-xanmod1-1"

```

### LinuxStat::Memory
```
# File: memory.rb | Line: 50
# Definition: def available
LinuxStat::Memory.available()
=> 842868

# File: memory.rb | Line: 81
# Definition: def percent_available
LinuxStat::Memory.percent_available()
=> 21.97

# File: memory.rb | Line: 70
# Definition: def percent_used
LinuxStat::Memory.percent_used()
=> 78.03

# File: memory.rb | Line: 11
# Definition: def stat
LinuxStat::Memory.stat()
=> {:total=>3836236, :used=>2993368, :available=>842868, :percent_used=>78.03, :percent_available=>21.97}

# File: memory.rb | Line: 40
# Definition: def total
LinuxStat::Memory.total()
=> 3836236

# File: memory.rb | Line: 60
# Definition: def used
LinuxStat::Memory.used()
=> 2993368

```

### LinuxStat::Mounts
```
# File: mounts.rb | Line: 179
# Definition: def device_stat(dev = root)
LinuxStat::Mounts.device_stat(dev)
=> {:mountpoint=>"/", :total=>119981191168, :free=>52424663040, :available=>52424663040, :used=>67556528128, :percent_used=>56.31, :percent_free=>43.69, :percent_available=>43.69}

# File: mounts.rb | Line: 137
# Definition: def devices_stat
LinuxStat::Mounts.devices_stat()
=> {"proc"=>{:mountpoint=>"/proc", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_free=>NaN, :percent_available=>NaN}, "sys"=>{:mountpoint=>"/sys", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_fre...

# File: mounts.rb | Line: 11
# Definition: def list
LinuxStat::Mounts.list()
=> ["proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0", "sys /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0", "dev /dev devtmpfs rw,nosuid,relatime,size=1892904k,nr_inodes=473226,mode=755 0 0", "run /run tmpfs rw,nosuid,nodev,relatime,mode=755 0 0", "...

# File: mounts.rb | Line: 20
# Definition: def list_devices
LinuxStat::Mounts.list_devices()
=> ["proc", "sys", "dev", "run", "/dev/sda2", "securityfs", "tmpfs", "devpts", "tmpfs", "cgroup2", "cgroup", "pstore", "none", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "systemd-1", "tra...

# File: mounts.rb | Line: 109
# Definition: def list_devices_mount_point
LinuxStat::Mounts.list_devices_mount_point()
=> {"proc"=>"/proc", "sys"=>"/sys", "dev"=>"/dev", "run"=>"/run", "/dev/sda2"=>"/", "securityfs"=>"/sys/kernel/security", "tmpfs"=>"/run/user/1000", "devpts"=>"/dev/pts", "cgroup2"=>"/sys/fs/cgroup/unified", "cgroup"=>"/sys/fs/cgroup/blkio", "pstore"=>"/...

# File: mounts.rb | Line: 80
# Definition: def mount_point(dev = root)
LinuxStat::Mounts.mount_point(dev)
=> "/"

# File: mounts.rb | Line: 29
# Definition: def root
LinuxStat::Mounts.root()
=> "/dev/sda2"

# File: mounts.rb | Line: 38
# Definition: def root_fs
LinuxStat::Mounts.root_fs()
=> "xfs"

# File: mounts.rb | Line: 47
# Definition: def root_mount_options
LinuxStat::Mounts.root_mount_options()
=> "rw,noatime,attr2,inode64,logbufs=8,logbsize=32k,noquota"

# File: mounts.rb | Line: 56
# Definition: def tmpfs
LinuxStat::Mounts.tmpfs()
=> {"/dev/shm"=>"tmpfs /dev/shm tmpfs rw,nosuid,nodev 0 0", "/sys/fs/cgroup"=>"tmpfs /sys/fs/cgroup tmpfs ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755 0 0", "/cache"=>"tmpfs /cache tmpfs rw,nosuid,nodev,relatime,size=2097152k 0 0", "/tmp"=>"...

```

### LinuxStat::Net
```
# File: net.rb | Line: 80
# Definition: def usage(interval = 0.1)
LinuxStat::Net.current_usage(interval)
=> {:received=>61200.0, :transmitted=>1880.0}

# File: net.rb | Line: 10
# Definition: def ipv4_private
LinuxStat::Net.ipv4_private()
=> "192.168.0.102"

# File: net.rb | Line: 23
# Definition: def total_bytes
LinuxStat::Net.total_bytes()
=> {:received=>1112357335, :transmitted=>289215998}

# File: net.rb | Line: 41
# Definition: def total_bytes_received
LinuxStat::Net.total_bytes_received()
=> 1112357335

# File: net.rb | Line: 54
# Definition: def total_bytes_transmitted
LinuxStat::Net.total_bytes_transmitted()
=> 289215998

# File: net.rb | Line: 80
# Definition: def usage(interval = 0.1)
LinuxStat::Net.usage(interval)
=> {:received=>61200.0, :transmitted=>1880.0}

```

### LinuxStat::OS
```
# File: os.rb | Line: 97
# Definition: def bits
LinuxStat::OS.bits()
=> 64

# File: os.rb | Line: 42
# Definition: def distribution
LinuxStat::OS.distribution()
=> "Arch Linux"

# File: os.rb | Line: 81
# Definition: def hostname
LinuxStat::OS.hostname()
=> "archlinux"

# File: os.rb | Line: 30
# Definition: def lsb_release
LinuxStat::OS.lsb_release()
=> {:LSB_VERSION=>"1.4", :DISTRIB_ID=>"Arch", :DISTRIB_RELEASE=>"rolling", :DISTRIB_DESCRIPTION=>"Arch Linux"}

# File: os.rb | Line: 64
# Definition: def machine
LinuxStat::OS.machine()
=> "x86_64"

# File: os.rb | Line: 72
# Definition: def nodename
LinuxStat::OS.nodename()
=> "archlinux"

# File: os.rb | Line: 15
# Definition: def os_release
LinuxStat::OS.os_release()
=> {:NAME=>"Arch Linux", :PRETTY_NAME=>"Arch Linux", :ID=>"arch", :BUILD_ID=>"rolling", :ANSI_COLOR=>"38;2;23;147;209", :HOME_URL=>"https://www.archlinux.org/", :DOCUMENTATION_URL=>"https://wiki.archlinux.org/", :SUPPORT_URL=>"https://bbs.archlinux.org/"...

# File: os.rb | Line: 110
# Definition: def uptime
LinuxStat::OS.uptime()
=> {:hour=>10, :minute=>49, :second=>25.48}

```

### LinuxStat::PrettifyBytes
```
# File: prettify_bytes.rb | Line: 42
# Definition: def convert_binary(n)
LinuxStat::PrettifyBytes.convert_binary(n = 304432464364884)
=> "276.88 tebibytes"

# File: prettify_bytes.rb | Line: 19
# Definition: def convert_decimal(n)
LinuxStat::PrettifyBytes.convert_decimal(n = 49306758655424)
=> "49.31 terabytes"

# File: prettify_bytes.rb | Line: 90
# Definition: def convert_short_binary(n)
LinuxStat::PrettifyBytes.convert_short_binary(n = 361176129377179)
=> "328.49 TiB"

# File: prettify_bytes.rb | Line: 65
# Definition: def convert_short_decimal(n)
LinuxStat::PrettifyBytes.convert_short_decimal(n = 293690574885959)
=> "293.69 TB"

```

### LinuxStat::Process
```
# File: process.rb | Line: 19
# Definition: def count
LinuxStat::Process.count()
=> 215

# File: process.rb | Line: 71
# Definition: def idle
LinuxStat::Process.idle()
=> [3, 4, 6, 9, 12, 23, 30, 37, 39, 49, 102, 103, 104, 106, 107, 108, 109, 110, 117, 118, 119, 121, 131, 134, 140, 152, 153, 169, 171, 173, 174, 177, 178, 183, 184, 185, 186, 187, 188, 231, 271, 373, 383, 18595, 21393, 21394, 21395, 21396, 21397, 21398,...

# File: process.rb | Line: 8
# Definition: def list
LinuxStat::Process.list()
=> [1, 2, 3, 4, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 46, 47, 48, 49, 50, 51, 52, 102, 103, 104, 106, 107, 108, 109, 110, 111, 114, 115, 117, 118, 119, 121, 131, 134,...

# File: process.rb | Line: 25
# Definition: def names
LinuxStat::Process.names()
=> {1=>"systemd", 2=>"kthreadd", 3=>"rcu_gp", 4=>"rcu_par_gp", 6=>"kworker/0:0H-kblockd", 9=>"mm_percpu_wq", 10=>"ksoftirqd/0", 11=>"rcuc/0", 12=>"rcu_preempt", 13=>"rcub/0", 14=>"migration/0", 15=>"idle_inject/0", 16=>"cpuhp/0", 17=>"cpuhp/1", 18=>"idle...

# File: process.rb | Line: 97
# Definition: def running
LinuxStat::Process.running()
=> [25641, 33756]

# File: process.rb | Line: 58
# Definition: def sleeping
LinuxStat::Process.sleeping()
=> [1, 2, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 38, 40, 41, 42, 46, 47, 48, 50, 51, 52, 111, 114, 115, 168, 170, 189, 218, 235, 301, 305, 309, 310, 311, 314, 315, 316, 317, 331, 334, 337, 403, 407, 409, 410,...

# File: process.rb | Line: 37
# Definition: def types
LinuxStat::Process.types()
=> {1=>:sleeping, 2=>:sleeping, 3=>:idle, 4=>:idle, 6=>:idle, 9=>:idle, 10=>:sleeping, 11=>:sleeping, 12=>:idle, 13=>:sleeping, 14=>:sleeping, 15=>:sleeping, 16=>:sleeping, 17=>:sleeping, 18=>:sleeping, 19=>:sleeping, 20=>:sleeping, 21=>:sleeping, 23=>:i...

# File: process.rb | Line: 84
# Definition: def zombie
LinuxStat::Process.zombie()
=> []

```

### LinuxStat::ProcessInfo
```
# File: process_info.rb | Line: 54
# Definition: def cmdline(pid = $$)
LinuxStat::ProcessInfo.cmdline(pid)
=> "ruby /usr/bin/linuxstat.rb -md"

# File: process_info.rb | Line: 78
# Definition: def command_name(pid = $$)
LinuxStat::ProcessInfo.command_name(pid)
=> "ruby"

# File: process_info.rb | Line: 247
# Definition: def cpu_stat(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.cpu_stat(pid:, sleep:)
=> {:cpu_usage=>0.0, :threads=>1, :last_executed_cpu=>2}

# File: process_info.rb | Line: 301
# Definition: def cpu_usage(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.cpu_usage(pid:, sleep:)
=> 0.0

# File: process_info.rb | Line: 454
# Definition: def gid(pid = $$)
LinuxStat::ProcessInfo.gid(pid)
=> {:real=>1000, :effective=>1000, :saved_set=>1000, :filesystem_uid=>1000}

# File: process_info.rb | Line: 417
# Definition: def last_executed_cpu(pid = $$)
LinuxStat::ProcessInfo.last_executed_cpu(pid)
=> 2

# File: process_info.rb | Line: 114
# Definition: def mem_stat(pid = $$)
LinuxStat::ProcessInfo.mem_stat(pid)
=> {:memory=>12292.096, :virtual_memory=>84049.92, :resident_memory=>18128.896}

# File: process_info.rb | Line: 147
# Definition: def memory(pid = $$)
LinuxStat::ProcessInfo.memory(pid)
=> 12292.096

# File: process_info.rb | Line: 588
# Definition: def nice(pid = $$)
LinuxStat::ProcessInfo.nice(pid)
=> 0

# File: process_info.rb | Line: 475
# Definition: def owner(pid = $$)
LinuxStat::ProcessInfo.owner(pid)
=> "sourav"

# File: process_info.rb | Line: 197
# Definition: def resident_memory(pid = $$)
LinuxStat::ProcessInfo.resident_memory(pid)
=> 18128.896

# File: process_info.rb | Line: 545
# Definition: def running_time(pid = $$)
LinuxStat::ProcessInfo.running_time(pid)
=> 1.639999999999418

# File: process_info.rb | Line: 528
# Definition: def start_time(pid = $$)
LinuxStat::ProcessInfo.start_time(pid)
=> 2020-12-17 21:56:57 +0530

# File: process_info.rb | Line: 497
# Definition: def start_time_epoch(pid = $$)
LinuxStat::ProcessInfo.start_time_epoch(pid)
=> 1608222417

# File: process_info.rb | Line: 573
# Definition: def state(pid = $$)
LinuxStat::ProcessInfo.state(pid)
=> "R"

# File: process_info.rb | Line: 349
# Definition: def thread_usage(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.thread_usage(pid:, sleep:)
=> 0.0

# File: process_info.rb | Line: 392
# Definition: def threads(pid = $$)
LinuxStat::ProcessInfo.threads(pid)
=> 1

# File: process_info.rb | Line: 23
# Definition: def total_io(pid = $$)
LinuxStat::ProcessInfo.total_io(pid)
=> {:read_bytes=>253952, :write_bytes=>0}

# File: process_info.rb | Line: 430
# Definition: def uid(pid = $$)
LinuxStat::ProcessInfo.uid(pid)
=> {:real=>1000, :effective=>1000, :saved_set=>1000, :filesystem_uid=>1000}

# File: process_info.rb | Line: 172
# Definition: def virtual_memory(pid = $$)
LinuxStat::ProcessInfo.virtual_memory(pid)
=> 84049.92

```

### LinuxStat::Swap
```
# File: swap.rb | Line: 22
# Definition: def any?
LinuxStat::Swap.any?()
=> true

# File: swap.rb | Line: 68
# Definition: def available
LinuxStat::Swap.available()
=> 3681532

# File: swap.rb | Line: 8
# Definition: def list
LinuxStat::Swap.list()
=> {"/dev/zram0"=>[:partition, 4194300, 512768, -2]}

# File: swap.rb | Line: 103
# Definition: def percent_available
LinuxStat::Swap.percent_available()
=> 87.77

# File: swap.rb | Line: 89
# Definition: def percent_used
LinuxStat::Swap.percent_used()
=> 12.23

# File: swap.rb | Line: 32
# Definition: def stat
LinuxStat::Swap.stat()
=> {:total=>4194300, :used=>512768, :available=>3681532, :percent_used=>12.23, :percent_available=>87.77}

# File: swap.rb | Line: 57
# Definition: def total
LinuxStat::Swap.total()
=> 4194300

# File: swap.rb | Line: 80
# Definition: def used
LinuxStat::Swap.used()
=> 512768

```

### LinuxStat::Sysconf
```
LinuxStat::Sysconf.child_max()
=> 2000000

LinuxStat::Sysconf.expr_nest_max()
=> 32

LinuxStat::Sysconf.get_euid()
=> 1000

LinuxStat::Sysconf.get_gid()
=> 1000

LinuxStat::Sysconf.get_login()
=> "sourav"

LinuxStat::Sysconf.get_uid()
=> 1000

LinuxStat::Sysconf.get_user()
=> "sourav"

LinuxStat::Sysconf.hostname_max()
=> 64

LinuxStat::Sysconf.line_max()
=> 2048

LinuxStat::Sysconf.login_name_max()
=> 256

LinuxStat::Sysconf.open_max()
=> 1024

LinuxStat::Sysconf.pagesize()
=> 4096

LinuxStat::Sysconf.posix_version()
=> 200809

LinuxStat::Sysconf.processor_configured()
=> 4

LinuxStat::Sysconf.processor_online()
=> 4

LinuxStat::Sysconf.sc_clk_tck()
=> 100

LinuxStat::Sysconf.stream_max()
=> 16

LinuxStat::Sysconf.tty_name_max()
=> 32

```

### LinuxStat::Uname
```
LinuxStat::Uname.machine()
=> "x86_64"

LinuxStat::Uname.nodename()
=> "archlinux"

LinuxStat::Uname.release()
=> "5.9.9-xanmod1-1"

LinuxStat::Uname.sysname()
=> "Linux"

LinuxStat::Uname.version()
=> "#1 SMP PREEMPT Fri, 20 Nov 2020 07:44:55 +0000"

```

### LinuxStat::User
```
# File: user.rb | Line: 98
# Definition: def get_user
LinuxStat::User.get_current_user()
=> "sourav"

# File: user.rb | Line: 137
# Definition: def get_euid
LinuxStat::User.get_euid()
=> 1000

# File: user.rb | Line: 129
# Definition: def get_gid
LinuxStat::User.get_gid()
=> 1000

# File: user.rb | Line: 152
# Definition: def get_login
LinuxStat::User.get_login()
=> "sourav"

# File: user.rb | Line: 121
# Definition: def get_uid
LinuxStat::User.get_uid()
=> 1000

# File: user.rb | Line: 98
# Definition: def get_user
LinuxStat::User.get_user()
=> "sourav"

# File: user.rb | Line: 215
# Definition: def gid_by_username(username = get_user)
LinuxStat::User.gid_by_username(username)
=> 1000

# File: user.rb | Line: 56
# Definition: def gids
LinuxStat::User.gids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>12, :ftp=>11, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :...

# File: user.rb | Line: 314
# Definition: def home_by_gid(id = get_gid)
LinuxStat::User.home_by_gid(id)
=> "/home/sourav"

# File: user.rb | Line: 266
# Definition: def home_by_username(user = get_user)
LinuxStat::User.home_by_username(user)
=> "/home/sourav"

# File: user.rb | Line: 72
# Definition: def home_directories
LinuxStat::User.home_directories()
=> {:root=>"/root", :bin=>"/", :daemon=>"/", :mail=>"/var/spool/mail", :ftp=>"/srv/ftp", :http=>"/srv/http", :nobody=>"/", :dbus=>"/", :"systemd-journal-remote"=>"/", :"systemd-network"=>"/", :"systemd-resolve"=>"/", :"systemd-timesync"=>"/", :"systemd-c...

# File: user.rb | Line: 293
# Definition: def homes_by_uid(id = get_uid)
LinuxStat::User.homes_by_uid(id)
=> ["/home/sourav"]

# File: user.rb | Line: 23
# Definition: def ids
LinuxStat::User.ids()
=> {:root=>{:uid=>0, :gid=>0}, :bin=>{:uid=>1, :gid=>1}, :daemon=>{:uid=>2, :gid=>2}, :mail=>{:uid=>8, :gid=>12}, :ftp=>{:uid=>14, :gid=>11}, :http=>{:uid=>33, :gid=>33}, :nobody=>{:uid=>65534, :gid=>65534}, :dbus=>{:uid=>81, :gid=>81}, :"systemd-journal...

# File: user.rb | Line: 11
# Definition: def list
LinuxStat::User.list()
=> ["root", "bin", "daemon", "mail", "ftp", "http", "nobody", "dbus", "systemd-journal-remote", "systemd-network", "systemd-resolve", "systemd-timesync", "systemd-coredump", "uuidd", "avahi", "colord", "git", "lxdm", "polkitd", "rtkit", "usbmux", "sourav...

# File: user.rb | Line: 244
# Definition: def uid_by_username(username = get_user)
LinuxStat::User.uid_by_username(username)
=> 1000

# File: user.rb | Line: 40
# Definition: def uids
LinuxStat::User.uids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>8, :ftp=>14, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :c...

# File: user.rb | Line: 187
# Definition: def username_by_gid(gid = get_gid)
LinuxStat::User.username_by_gid(gid)
=> "sourav"

# File: user.rb | Line: 169
# Definition: def usernames_by_uid(uid = get_uid)
LinuxStat::User.usernames_by_uid(uid)
=> ["sourav"]

```

---

## Note 1: CPU usage, and Net usage
To calculate the current usage, we need to get two usages at a given interval, and subtract the 2nd from the 1st.
For example, if the current download (`LinuxStat::Net.total_bytes_received`) is 1000 bytes, and if 0.1 seconds ago, it was 100 bytes, that means 900 bytes was received in 0.1 seconds.
That means the current speed is 9000 bytes/s or 9 kB/s.

Without the polling, it's not really possible to calculate the current usage. Although the total usage can be calculated.
A system monitor does that, too...

Thus these methods requires a polling interval:

1. LinuxStat::CPU.stat, usage, total_usage, usage.
2. LinuxStat::ProcessInfo.cpu_usage, cpu_stat.
3. LinuxStat::Net.usage, current_usage.

They sleep for a given interval and then differentiate between the data.

For more info look at the ri documentation for the above methods.

These methods can slow down your application a bit unless you implement them in a thread.

Other methods doesn't have the sleep implemented, and they just works under a millisecond.

For example:

```
LinuxStat::CPU.stat(0.1)
=> {0=>7.69, 1=>0.0, 2=>0.0, 3=>18.18, 4=>10.0}
```
This will sleep for 0.1 seconds. To be reliable, use a time like 0.05 seconds or so.

If you want to build a system monitor and don't want to wait, you have to do something like this:

```
#!/usr/bin/ruby
require 'linux_stat'

usages = []
thread = Thread.new { }
counter = 0

while true
	thread = Thread.new { usages = LinuxStat::CPU.usages(0.5).values } unless thread.alive?

	# clears the screen and prints the info
	puts "\e[2J\e[H\e[3J"\
	"#{counter += 1}\n"\
	"\e[1;33mTotal CPU Usage:\e[0m #{usages[0]}%\n"\
	"#{usages[1..-1].to_a.map.with_index { |x, i| "\e[1;33mCore #{i}\e[0m => #{x}%\n" }.join}"\
	"Total Download: #{LinuxStat::PrettifyBytes.convert_decimal LinuxStat::Net.total_bytes_received}\n"\
	"Total Upload: #{LinuxStat::PrettifyBytes.convert_decimal LinuxStat::Net.total_bytes_transmitted}"
end
```

This will not wait in every loop for 0.5 seconds, but it will not update the cpu usage in every loop either.
So what you will be seeing in the CPU usage in every 0.5 seconds interval.

You will also see the counter increases like crazy. Which means it's not getting waited for 0.5 seconds.

But the other methods doesn't have this delay, thus in this example,
you will be able see the "Total Download" and "Total Upload" in real time,
well as soon as the Linux kernel updates the data and ruby executes the loop.

Just run the linuxstat.rb command to test what method takes what time measured in microseconds.

## Note 2: Filesystem

Filesystem can take arguments. By default it's '/' or the root of the system...

But for the sake of example, to get the free disk space of /, you do:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::Filesystem.free('/').fdiv(1024 ** 3).to_s << " GiB"
=> "35.666873931884766 GiB"
```

To see the free and total space of a thumbdrive:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::Mounts.mount_point('/dev/sdb1')
=> "/run/media/sourav/5c2b7af7-d4c3-4ab4-a035-06d18ffc8e6f"

irb(main):003:0> thumbdrive = _
=> "/run/media/sourav/5c2b7af7-d4c3-4ab4-a035-06d18ffc8e6f"

irb(main):004:0> LinuxStat::Filesystem.free(thumbdrive).fdiv(1024 ** 3).to_s << " GiB"
=> "2.504791259765625 GiB"

irb(main):005:0> LinuxStat::Filesystem.total(thumbdrive).fdiv(1024 ** 3).to_s << " GiB"
=> "29.305004119873047 GiB"
```

## Note 3: ProcessInfo

All the methods LinuxStat::ProcessInfo can take an argument containing the Process ID of a process.
By default it's $$ or the PID of the current process, ruby, itself.

Example:
Say you want to see how much CPU Firefox is consuming, for that you have to do the following (firefox can create a lot of child process though):

1. Get the PID of Firefox:
```
LinuxStat::Process.names.find { |x| x[1].include? 'firefox' }[0]
=> 770 # but this differs all the time
```

2. Get the CPU usage:
```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> pid = LinuxStat::Process.names.find { |x| x[1].include? 'firefox' }[0]
=> 770

irb(main):003:0> LinuxStat::ProcessInfo.cpu_usage(pid: pid)
=> 0.0

irb(main):004:0> LinuxStat::ProcessInfo.cpu_usage(pid: pid)
=> 15.0
```

To get the memory usage of Firefox (for example):

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::ProcessInfo.mem_stat(LinuxStat::Process.names.find { |x| x[1].include? 'firefox'.freeze }[0])
=> {:memory=>468472, :virtual_memory=>4754080, :resident_memory=>814388}
```

To get ONLY the memory usage in MiB:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::ProcessInfo.memory(LinuxStat::Process.names.find { |x| x[1].include? 'firefox'.freeze }[0]).fdiv(1024).round(2).to_s << " MiB"
=> "467.51 MiB"
```

## Note 4: FS

LinuxStat::FS module gives you the raw info in Hash collected from statvfs.

It's not documented above because it's not suggested to run this directly. But it shouldn't cause any issue. `LinuxStat::Filesystem.stat_raw(fs = '/')` does that automatically.

It always requires an argument, and it's very fast. It directly calls the C API without any intermediate Ruby code.

For example, to get the info about '/' or root:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::FS.stat('/')
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>9349843, :block_avail_unpriv=>9349843, :inodes=>58612160, :free_inodes=>56708247, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

irb(main):003:0> t = Time.now ; puts LinuxStat::FS.stat('/') ; Time.now - t
{:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>9349843, :block_avail_unpriv=>9349843, :inodes=>58612160, :free_inodes=>56708247, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}
=> 5.0468e-05
```

To learn more about them, just run ri and the method name. To see all available methods.

## Note 5: User
Most of the LinuxStat::User supports arguments.

For example, to get a user's home by the username:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::User.home_by_username('root')
=> "/root"

irb(main):003:0> LinuxStat::User.home_by_username('ftp')
=> "/srv/ftp"

irb(main):004:0> LinuxStat::User.home_by_username('mail')
=> "/var/spool/mail"
```

Or to get the user's home by the GID/UID:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::User.homes_by_uid(1001)
=> ["/home/userx", "/home/userz"]

irb(main):003:0> LinuxStat::User.homes_by_uid(1000)
=> ["/home/sourav"]

irb(main):004:0> LinuxStat::User.home_by_gid(1001)
=> "/home/userx"

irb(main):005:0> LinuxStat::User.home_by_gid(1000)
=> "/home/sourav"

irb(main):006:0> LinuxStat::User.home_by_gid(0)
=> "/root"
```

Or to get the UID/GID by username:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::User.uid_by_username('root')
=> 0

irb(main):003:0> LinuxStat::User.uid_by_username('ftp')
=> 14

irb(main):004:0> LinuxStat::User.gid_by_username('ftp')
=> 11

irb(main):005:0> LinuxStat::User.gid_by_username('InvalidUser')
=> nil
```

Or to get the current user (in docker for example):

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::User.get_current_user
=> "x"

irb(main):003:0> LinuxStat::User.get_user
=> "x"

irb(main):004:0> LinuxStat::User.get_login
=> ""
```

Right, the get_login() can return an empty string. But LinuxStat::User.get_user also aliased as LinuxStat::User.get_current_user shouldn't return an empty string under most circumstances.

## Note 6: PrettifyBytes
Often times we need to work with KB, MB GB, TB, or KiB, MiB, GiB, TiB, etc.
And we need some work to convert bytes to those units.
Because LinuxStat provides a lot of data in bytes, and kilobytes, it's quite tedious to convert them all the time.
To avoid such duplication, it comes with a PrettifyBytes module.

For example, to convert bytes to decimal suffixes:

```
$irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::PrettifyBytes.convert_decimal(1000)
=> "1.00 kilobyte"

irb(main):003:0> LinuxStat::PrettifyBytes.convert_decimal(10000)
=> "10.00 kilobytes"

irb(main):004:0> LinuxStat::PrettifyBytes.convert_decimal(100000)
=> "100.00 kilobytes"

irb(main):005:0> LinuxStat::PrettifyBytes.convert_decimal(10 ** 13)
=> "10.00 terabytes"
```

To convert bytes to binary suffixes:

```
irb(main):006:0> LinuxStat::PrettifyBytes.convert_binary(1000)
=> "1000.00 bytes"

irb(main):007:0> LinuxStat::PrettifyBytes.convert_binary(10000)
=> "9.77 kibibytes"

irb(main):008:0> LinuxStat::PrettifyBytes.convert_binary(100000)
=> "97.66 kibibytes"

irb(main):009:0> LinuxStat::PrettifyBytes.convert_binary(10 ** 13)
=> "9.09 tebibytes"
```

To convert them to short Metric decimal suffixes:

```
irb(main):010:0> LinuxStat::PrettifyBytes.convert_short_decimal(1000)
=> "1.00 kB"

irb(main):011:0> LinuxStat::PrettifyBytes.convert_short_decimal(10000)
=> "10.00 kB"

irb(main):012:0> LinuxStat::PrettifyBytes.convert_short_decimal(100000)
=> "100.00 kB"

irb(main):013:0> LinuxStat::PrettifyBytes.convert_short_decimal(10 ** 13)
=> "10.00 TB"
```

To convert them to short IEC binary suffixes:

```
irb(main):014:0> LinuxStat::PrettifyBytes.convert_short_binary(1000)
=> "1000 B"

irb(main):015:0> LinuxStat::PrettifyBytes.convert_short_binary(10000)
=> "9.77 KiB"

irb(main):016:0> LinuxStat::PrettifyBytes.convert_short_binary(100000)
=> "97.66 KiB"

irb(main):017:0> LinuxStat::PrettifyBytes.convert_short_binary(10 ** 13)
=> "9.09 TiB"
```

It can support values upto hundreds of yottabytes and yobibytes, or yb and yib. You can also do stuff like:

```
$ irb
irb(main):001:0> require 'linux_stat'
=> true

irb(main):002:0> LinuxStat::PrettifyBytes.convert_short_decimal(LinuxStat::Mounts.device_stat('/dev/sdb1')[:total])
=> "31.47 GB"

irb(main):003:0> LinuxStat::PrettifyBytes.convert_short_binary(LinuxStat::Mounts.device_stat('/dev/sdb1')[:total])
=> "29.31 GiB"

irb(main):004:0> LinuxStat::PrettifyBytes.convert_short_binary(LinuxStat::Mounts.device_stat('/dev/sdb1')[:used])
=> "26.80 GiB"

irb(main):005:0> LinuxStat::PrettifyBytes.convert_short_binary(LinuxStat::Mounts.device_stat('/dev/sdb1')[:available])
=> "2.51 GiB"
```

Read the ri documentation for more info.

---

## Return Types
+ In general, if a method returns either a Float or a Integer or a Time, it will return a Float or Integer or Time in all cases. But if the status isn't available, it will return nil.

+ If the method returns a Hash / Array, it will return return Hash / Array in all cases. If the status isn't available, it will return an empty Hash / Array.

+ If the method returns a String, it will return return String in all cases. If the status isn't available, it will return an empty *frozen* String.

+ It doesn't have implementation of any Error that gets raised in runtime for the ease of use.

+ If you need to check some stat that returns an integer or float, and you get nil, you know it's not available, so you can work accordingly. But if you need the integer or float value in 0 to whatever format, you can use the .to_i or .to_f method on the object, nil will get converted to number then.

If some error is *raised* it should be reported as a bug.

---

## Ruby on Rails

1. Just add `gem linux_stat`:

```
$ bundle add linux_stat
```

You can use LinuxStat directly in rails.

![RailsApp](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/images/rails.gif)

---

## Android

LinuxStat does support Android OS. But it's not rigorously tested on all device like android apps.

But in Termux you can just run LinuxStat without facing issues.
Note that the CPU count can differ due to hotplugging feature. So if you see the CPU count changes, there's not really nothing to do about that.

![termux](https://raw.githubusercontent.com/Souravgoswami/linux_stat/master/images/termux.webp)

Issues regarding running LinuxStat on termux are also welcomed.

---

## Development
After checking out the repo, compile and install this gem onto your local machine with `bundle exec rake install`

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To test all modules, run `rake install` and then `exe/linuxstat.rb`. Also check "Testing" below.

---

## Testing
Like other gems, this doesn't have a test like RSpec.

We suggest using the exe/linuxstat.rb file on various Linux systems to test.

First you need to execute `bundle exec rake install` to compile and install this gem.

If you need to test a specific module, say the CPU, just run it like this:

```
$ ruby exe/linuxstat.rb CPU
```

Or:
```
$ ruby exe/linuxstat.rb cpu
```

That is, the argument passed is not case-sensitive.
But if the argument passed isn't available and outright wrong, it will run all the module methods. For example, you can't do:

```
$ ruby exe/linuxstat.rb upc
```
This is not a valid module and can't be run.

---

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Souravgoswami/linux_stat.

---

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
