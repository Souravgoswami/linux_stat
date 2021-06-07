### LinuxStat::BIOS
```
# File:         bios.rb | Line: 58
# Definition:   def date
LinuxStat::BIOS.date()
=> "04/10/2017"

# File:         bios.rb | Line: 12
# Definition:   def model
LinuxStat::BIOS.model()
=> "Inspiron 5567"

# File:         bios.rb | Line: 29
# Definition:   def vendor
LinuxStat::BIOS.vendor()
=> "Dell Inc."

# File:         bios.rb | Line: 44
# Definition:   def version
LinuxStat::BIOS.version()
=> "1.1.2"

```

### LinuxStat::Battery
```
# File:         battery.rb | Line: 107
# Definition:   def charge
LinuxStat::Battery.charge()
=> 100.0

# File:         battery.rb | Line: 132
# Definition:   def charge_full_design_wh
LinuxStat::Battery.charge_full_design_wh()
=> 43.32

# File:         battery.rb | Line: 151
# Definition:   def charge_full_wh
LinuxStat::Battery.charge_full_wh()
=> 25.08

# File:         battery.rb | Line: 80
# Definition:   def charging?
LinuxStat::Battery.charging?()
=> true

# File:         battery.rb | Line: 201
# Definition:   def devices_stat
LinuxStat::Battery.devices_stat()
=> {:AC=>{:type=>"Mains", :online=>1}, :BAT0=>{:model=>"DELL 35RH35C", :manufacturer=>"SMP", :type=>"Battery", :status=>"Full", :capacity=>100, :voltage_min_design=>11.4, :charge_full_design=>3.8, :charge_full_design_wh=>43.32, :voltage_now=>12.349, :cha...

# File:         battery.rb | Line: 89
# Definition:   def discharging?
LinuxStat::Battery.discharging?()
=> false

# File:         battery.rb | Line: 98
# Definition:   def full?
LinuxStat::Battery.full?()
=> true

# File:         battery.rb | Line: 49
# Definition:   def manufacturer
LinuxStat::Battery.manufacturer()
=> "SMP"

# File:         battery.rb | Line: 38
# Definition:   def model
LinuxStat::Battery.model()
=> "DELL 35RH35C"

# File:         battery.rb | Line: 10
# Definition:   def present?
LinuxStat::Battery.present?()
=> true

# File:         battery.rb | Line: 18
# Definition:   def stat
LinuxStat::Battery.stat()
=> {:model=>"DELL 35RH35C", :manufacturer=>"SMP", :technology=>"Li-ion", :status=>"Full", :charge=>100.0, :charging=>true, :discharging=>false, :full=>true}

# File:         battery.rb | Line: 70
# Definition:   def status
LinuxStat::Battery.status()
=> "Full"

# File:         battery.rb | Line: 59
# Definition:   def technology
LinuxStat::Battery.technology()
=> "Li-ion"

# File:         battery.rb | Line: 170
# Definition:   def voltage_now
LinuxStat::Battery.voltage_now()
=> 12.349

```

### LinuxStat::CPU
```
# File:         cpu.rb | Line: 289
# Definition:   def available_governors
LinuxStat::CPU.available_governors()
=> {"cpu0"=>["performance", "powersave"], "cpu1"=>["performance", "powersave"], "cpu2"=>["performance", "powersave"], "cpu3"=>["performance", "powersave"]}

# File:         cpu.rb | Line: 88
# Definition:   def count
LinuxStat::CPU.count()
=> 4

# File:         cpu.rb | Line: 105
# Definition:   def count_online
LinuxStat::CPU.count_online()
=> 4

# File:         cpu.rb | Line: 199
# Definition:   def cur_freq
LinuxStat::CPU.cur_freq()
=> {"cpu0"=>2000005, "cpu1"=>1953892, "cpu2"=>1999637, "cpu3"=>2000038}

# File:         cpu.rb | Line: 267
# Definition:   def governor
LinuxStat::CPU.governor()
=> {"cpu0"=>"performance", "cpu1"=>"performance", "cpu2"=>"performance", "cpu3"=>"performance"}

# File:         cpu.rb | Line: 243
# Definition:   def max_freq
LinuxStat::CPU.max_freq()
=> {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}

# File:         cpu.rb | Line: 221
# Definition:   def min_freq
LinuxStat::CPU.min_freq()
=> {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}

# File:         cpu.rb | Line: 186
# Definition:   def model
LinuxStat::CPU.model()
=> "Intel(R) Core(TM) i3-6006U CPU @ 2.00GHz"

# File:         cpu.rb | Line: 165
# Definition:   def offline
LinuxStat::CPU.offline()
=> []

# File:         cpu.rb | Line: 134
# Definition:   def online
LinuxStat::CPU.online()
=> [0, 1, 2, 3]

# File:         cpu.rb | Line: 25
# Definition:   def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.stat(sleep)
=> {0=>15.0, 1=>0.0, 2=>20.0, 3=>20.0, 4=>16.67}

# File:         cpu.rb | Line: 65
# Definition:   def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.total_usage(sleep)
=> 15.0

# File:         cpu.rb | Line: 65
# Definition:   def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usage(sleep)
=> 15.0

# File:         cpu.rb | Line: 25
# Definition:   def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usages(sleep)
=> {0=>19.05, 1=>0.0, 2=>20.0, 3=>16.67, 4=>0.0}

```

### LinuxStat::FS
```
LinuxStat::FS.sectors(arg = "/")
=> nil

LinuxStat::FS.stat(arg = "/")
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>1917274, :block_avail_unpriv=>1917274, :inodes=>17470608, :free_inodes=>15383185, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

LinuxStat::FS.total_io(arg = "/")
=> []

```

### LinuxStat::Filesystem
```
# File:         filesystem.rb | Line: 94
# Definition:   def available(fs = ?..freeze)
LinuxStat::Filesystem.available(fs)
=> 7853154304

# File:         filesystem.rb | Line: 60
# Definition:   def free(fs = ?..freeze)
LinuxStat::Filesystem.free(fs)
=> 7853154304

# File:         filesystem.rb | Line: 118
# Definition:   def io_total(path = LinuxStat::Mounts.root)
LinuxStat::Filesystem.io_total(path)
=> {:read=>2132713472, :write=>2006025728}

# File:         filesystem.rb | Line: 133
# Definition:   def io_usage(path = LinuxStat::Mounts.root, interval = 0.1)
LinuxStat::Filesystem.io_usage(path, interval)
=> {:read=>0.0, :write=>0.0}

# File:         filesystem.rb | Line: 114
# Definition:   def sector_size(path = LinuxStat::Mounts.root)
LinuxStat::Filesystem.sector_size(path)
=> 512

# File:         filesystem.rb | Line: 114
# Definition:   def sector_size(path = LinuxStat::Mounts.root)
LinuxStat::Filesystem.sectors(path)
=> 512

# File:         filesystem.rb | Line: 21
# Definition:   def stat(fs = ?..freeze)
LinuxStat::Filesystem.stat(fs)
=> {:total=>119981191168, :free=>7853154304, :used=>112128036864}

# File:         filesystem.rb | Line: 110
# Definition:   def stat_raw(fs = ?..freeze)
LinuxStat::Filesystem.stat_raw(fs)
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>1917274, :block_avail_unpriv=>1917274, :inodes=>17470608, :free_inodes=>15383185, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

# File:         filesystem.rb | Line: 41
# Definition:   def total(fs = ?..freeze)
LinuxStat::Filesystem.total(fs)
=> 119981191168

# File:         filesystem.rb | Line: 75
# Definition:   def used(fs = ?..freeze)
LinuxStat::Filesystem.used(fs)
=> 112128036864

```

### LinuxStat::Kernel
```
# File:         kernel.rb | Line: 88
# Definition:   def build_date
LinuxStat::Kernel.build_date()
=> 2021-05-28 23:08:03 +0000

# File:         kernel.rb | Line: 142
# Definition:   def build_date_string
LinuxStat::Kernel.build_date_string()
=> "28 May 2021 23:08:03 +0000"

# File:         kernel.rb | Line: 23
# Definition:   def build_user
LinuxStat::Kernel.build_user()
=> "souravgoswami@archlinux"

# File:         kernel.rb | Line: 181
# Definition:   def ticks
LinuxStat::Kernel.clk_tck()
=> 100

# File:         kernel.rb | Line: 35
# Definition:   def compiler
LinuxStat::Kernel.compiler()
=> [:gcc, "11.1.0"]

# File:         kernel.rb | Line: 57
# Definition:   def compiler_version
LinuxStat::Kernel.compiler_version()
=> "11.1.0"

# File:         kernel.rb | Line: 12
# Definition:   def version
LinuxStat::Kernel.release()
=> "5.12.8-xanmod1-cacule-1-cacule"

# File:         kernel.rb | Line: 171
# Definition:   def string
LinuxStat::Kernel.string()
=> "Linux version 5.12.8-xanmod1-cacule-1-cacule (souravgoswami@archlinux) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Fri, 28 May 2021 23:08:03 +0000"

# File:         kernel.rb | Line: 181
# Definition:   def ticks
LinuxStat::Kernel.ticks()
=> 100

# File:         kernel.rb | Line: 12
# Definition:   def version
LinuxStat::Kernel.version()
=> "5.12.8-xanmod1-cacule-1-cacule"

```

### LinuxStat::Memory
```
# File:         memory.rb | Line: 62
# Definition:   def available
LinuxStat::Memory.available()
=> 4089324

# File:         memory.rb | Line: 52
# Definition:   def free
LinuxStat::Memory.free()
=> 2321472

# File:         memory.rb | Line: 93
# Definition:   def percent_available
LinuxStat::Memory.percent_available()
=> 51.37

# File:         memory.rb | Line: 82
# Definition:   def percent_used
LinuxStat::Memory.percent_used()
=> 48.63

# File:         memory.rb | Line: 13
# Definition:   def stat
LinuxStat::Memory.stat()
=> {:total=>7960868, :used=>3871544, :available=>4089324, :percent_used=>48.63, :percent_available=>51.37}

# File:         memory.rb | Line: 42
# Definition:   def total
LinuxStat::Memory.total()
=> 7960868

# File:         memory.rb | Line: 72
# Definition:   def used
LinuxStat::Memory.used()
=> 3871544

```

### LinuxStat::Mounts
```
# File:         mounts.rb | Line: 181
# Definition:   def device_stat(dev = root)
LinuxStat::Mounts.device_stat(dev)
=> {:mountpoint=>"/", :total=>119981191168, :free=>7853154304, :available=>7853154304, :used=>112128036864, :percent_used=>93.45, :percent_free=>6.55, :percent_available=>6.55}

# File:         mounts.rb | Line: 139
# Definition:   def devices_stat
LinuxStat::Mounts.devices_stat()
=> {"proc"=>{:mountpoint=>"/proc", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_free=>NaN, :percent_available=>NaN}, "sys"=>{:mountpoint=>"/sys", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_fre...

# File:         mounts.rb | Line: 13
# Definition:   def list
LinuxStat::Mounts.list()
=> ["proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0", "sys /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0", "dev /dev devtmpfs rw,nosuid,relatime,size=3971456k,nr_inodes=992864,mode=755,inode64 0 0", "run /run tmpfs rw,nosuid,nodev,relatime,mode=755...

# File:         mounts.rb | Line: 22
# Definition:   def list_devices
LinuxStat::Mounts.list_devices()
=> ["proc", "sys", "dev", "run", "/dev/sda2", "securityfs", "tmpfs", "devpts", "cgroup2", "pstore", "none", "systemd-1", "hugetlbfs", "debugfs", "mqueue", "configfs", "fusectl", "tmpfs", "tmpfs", "tmpfs", "tmpfs", "gvfsd-fuse", "binfmt_misc"]

# File:         mounts.rb | Line: 111
# Definition:   def list_devices_mount_point
LinuxStat::Mounts.list_devices_mount_point()
=> {"proc"=>"/proc", "sys"=>"/sys", "dev"=>"/dev", "run"=>"/run", "/dev/sda2"=>"/", "securityfs"=>"/sys/kernel/security", "tmpfs"=>"/run/user/1000", "devpts"=>"/dev/pts", "cgroup2"=>"/sys/fs/cgroup", "pstore"=>"/sys/fs/pstore", "none"=>"/sys/fs/bpf", "sy...

# File:         mounts.rb | Line: 82
# Definition:   def mount_point(dev = root)
LinuxStat::Mounts.mount_point(dev)
=> "/"

# File:         mounts.rb | Line: 31
# Definition:   def root
LinuxStat::Mounts.root()
=> "/dev/sda2"

# File:         mounts.rb | Line: 40
# Definition:   def root_fs
LinuxStat::Mounts.root_fs()
=> "xfs"

# File:         mounts.rb | Line: 49
# Definition:   def root_mount_options
LinuxStat::Mounts.root_mount_options()
=> "rw,noatime,attr2,inode64,logbufs=8,logbsize=32k,noquota"

# File:         mounts.rb | Line: 58
# Definition:   def tmpfs
LinuxStat::Mounts.tmpfs()
=> {"/dev/shm"=>"tmpfs /dev/shm tmpfs rw,nosuid,nodev,inode64 0 0", "/cache"=>"tmpfs /cache tmpfs rw,nosuid,nodev,relatime,size=2097152k,inode64 0 0", "/ramdisk"=>"tmpfs /ramdisk tmpfs rw,nosuid,nodev,relatime,size=6291456k,inode64 0 0", "/tmp"=>"tmpfs /...

```

### LinuxStat::Net
```
# File:         net.rb | Line: 86
# Definition:   def usage(interval = 0.1)
LinuxStat::Net.current_usage(interval)
=> {:received=>0.0, :transmitted=>0.0}

# File:         net.rb | Line: 12
# Definition:   def ipv4_private
LinuxStat::Net.ipv4_private()
=> "192.168.0.3"

# File:         net.rb | Line: 27
# Definition:   def total_bytes
LinuxStat::Net.total_bytes()
=> {:received=>262164203, :transmitted=>19762734}

# File:         net.rb | Line: 45
# Definition:   def total_bytes_received
LinuxStat::Net.total_bytes_received()
=> 262164203

# File:         net.rb | Line: 58
# Definition:   def total_bytes_transmitted
LinuxStat::Net.total_bytes_transmitted()
=> 19762734

# File:         net.rb | Line: 86
# Definition:   def usage(interval = 0.1)
LinuxStat::Net.usage(interval)
=> {:received=>0.0, :transmitted=>0.0}

```

### LinuxStat::OS
```
# File:         os.rb | Line: 133
# Definition:   def bits
LinuxStat::OS.bits()
=> 64

# File:         os.rb | Line: 88
# Definition:   def version
LinuxStat::OS.distrib_version()
=> "rolling"

# File:         os.rb | Line: 50
# Definition:   def distribution
LinuxStat::OS.distribution()
=> "Arch Linux"

# File:         os.rb | Line: 121
# Definition:   def hostname
LinuxStat::OS.hostname()
=> "archlinux"

# File:         os.rb | Line: 208
# Definition:   def loadavg
LinuxStat::OS.loadavg()
=> {1=>1.8173828125, 5=>1.2158203125, 15=>0.89794921875}

# File:         os.rb | Line: 39
# Definition:   def lsb_release
LinuxStat::OS.lsb_release()
=> {:LSB_VERSION=>"1.4", :DISTRIB_ID=>"Arch", :DISTRIB_RELEASE=>"rolling", :DISTRIB_DESCRIPTION=>"Arch Linux"}

# File:         os.rb | Line: 104
# Definition:   def machine
LinuxStat::OS.machine()
=> "x86_64"

# File:         os.rb | Line: 112
# Definition:   def nodename
LinuxStat::OS.nodename()
=> "archlinux"

# File:         os.rb | Line: 23
# Definition:   def os_release
LinuxStat::OS.os_release()
=> {:NAME=>"Arch Linux", :PRETTY_NAME=>"Arch Linux", :ID=>"arch", :BUILD_ID=>"rolling", :ANSI_COLOR=>"38;2;23;147;209", :HOME_URL=>"https://archlinux.org/", :DOCUMENTATION_URL=>"https://wiki.archlinux.org/", :SUPPORT_URL=>"https://bbs.archlinux.org/", :B...

# File:         os.rb | Line: 150
# Definition:   def uptime
LinuxStat::OS.uptime()
=> {:hour=>2, :minute=>45, :second=>29, :jiffy=>62}

# File:         os.rb | Line: 180
# Definition:   def uptime_f
LinuxStat::OS.uptime_f()
=> 9929.62

# File:         os.rb | Line: 191
# Definition:   def uptime_i
LinuxStat::OS.uptime_i()
=> 9930

# File:         os.rb | Line: 88
# Definition:   def version
LinuxStat::OS.version()
=> "rolling"

```

### LinuxStat::PCI
```
# File:         pci.rb | Line: 216
# Definition:   def count
LinuxStat::PCI.count()
=> 15

# File:         pci.rb | Line: 216
# Definition:   def count
LinuxStat::PCI.count_devices()
=> 15

# File:         pci.rb | Line: 54
# Definition:   def devices_info(hwdata: true)
LinuxStat::PCI.devices_info(hwdata:)
=> [{:id=>"8086:1904", :vendor=>"8086", :device=>"1904", :irq=>0, :kernel_driver=>"skl_uncore", :hwdata=>{:vendor=>"Intel Corporation", :product=>"Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers"}}, {:id=>"8086:1916", :vendor...

# File:         pci.rb | Line: 130
# Definition:   def devices_stat(hwdata: true)
LinuxStat::PCI.devices_stat(hwdata:)
=> [{:path=>"/sys/bus/pci/devices/0000:00:00.0/", :id=>"8086:1904", :vendor=>"8086", :device=>"1904", :sub_vendor=>"1028", :sub_device=>"077d", :kernel_driver=>"skl_uncore", :revision=>"0x08", :irq=>0, :enable=>false, :hwdata=>{:vendor=>"Intel Corporatio...

# File:         pci.rb | Line: 264
# Definition:   def hwdata_file
LinuxStat::PCI.hwdata_file()
=> "/usr/share/hwdata/pci.ids"

# File:         pci.rb | Line: 253
# Definition:   def hwdata_file_set?
LinuxStat::PCI.hwdata_file_set?()
=> true

# File:         pci.rb | Line: 280
# Definition:   def initialize_hwdata
LinuxStat::PCI.initialize_hwdata()
=> false

```

### LinuxStat::PrettifyBytes
```
# File:         prettify_bytes.rb | Line: 92
# Definition:   def convert_binary(n, precision: 2)
LinuxStat::PrettifyBytes.convert_binary(n = 636606342278608, precision:)
=> "578.99 tebibytes"

# File:         prettify_bytes.rb | Line: 48
# Definition:   def convert_decimal(n, precision: 2)
LinuxStat::PrettifyBytes.convert_decimal(n = 937236097561445, precision:)
=> "937.24 terabytes"

# File:         prettify_bytes.rb | Line: 182
# Definition:   def convert_short_binary(n, precision: 2)
LinuxStat::PrettifyBytes.convert_short_binary(n = 823780451218562, precision:)
=> "749.22 TiB"

# File:         prettify_bytes.rb | Line: 136
# Definition:   def convert_short_decimal(n, precision: 2)
LinuxStat::PrettifyBytes.convert_short_decimal(n = 432162477076780, precision:)
=> "432.16 TB"

```

### LinuxStat::ProcFS
```
LinuxStat::ProcFS.last_pid()
=> 11502

LinuxStat::ProcFS.uptime_f()
=> 9929.85

```

### LinuxStat::Process
```
# File:         process.rb | Line: 57
# Definition:   def cmdlines
LinuxStat::Process.cmdlines()
=> {1=>"/sbin/init", 10=>"", 1009=>"/usr/lib/gvfsd-trash --spawner :1.5 /org/gtk/gvfs/exec_spaw/0", 101=>"", 102=>"", 10241=>"", 10247=>"", 1028=>"/usr/lib/gvfsd-network --spawner :1.5 /org/gtk/gvfs/exec_spaw/1", 103=>"", 10396=>"", 1040=>"/usr/lib/gvfsd...

# File:         process.rb | Line: 29
# Definition:   def count
LinuxStat::Process.count()
=> 205

# File:         process.rb | Line: 120
# Definition:   def idle
LinuxStat::Process.idle()
=> [101, 102, 10241, 10247, 103, 10396, 10409, 105, 10580, 106, 10645, 10692, 107, 108, 109, 112, 11454, 118, 119, 121, 124, 126, 134, 137, 138, 139, 14, 140, 145, 173, 177, 179, 181, 192, 193, 194, 195, 196, 197, 198, 199, 206, 242, 245, 246, 247, 25, 2...

# File:         process.rb | Line: 160
# Definition:   def last_pid
LinuxStat::Process.last_pid()
=> 11502

# File:         process.rb | Line: 11
# Definition:   def list
LinuxStat::Process.list()
=> [1, 10, 1009, 101, 102, 10241, 10247, 1028, 103, 10396, 1040, 10408, 10409, 10410, 105, 10580, 106, 10630, 10645, 10692, 107, 108, 109, 11, 110, 1113, 112, 11454, 11499, 115, 11500, 11501, 116, 118, 119, 12, 1201, 121, 124, 126, 1261, 1283, 13, 1306,...

# File:         process.rb | Line: 36
# Definition:   def names
LinuxStat::Process.names()
=> {1=>"systemd", 10=>"rcu_tasks_kthre", 1009=>"gvfsd-trash", 101=>"kintegrityd", 102=>"kblockd", 10241=>"kworker/1:1-events", 10247=>"kworker/u8:3-events_unbound", 1028=>"gvfsd-network", 103=>"blkcg_punt_bio", 10396=>"kworker/3:1-events", 1040=>"gvfsd-d...

# File:         process.rb | Line: 138
# Definition:   def running
LinuxStat::Process.running()
=> [11501]

# File:         process.rb | Line: 111
# Definition:   def sleeping
LinuxStat::Process.sleeping()
=> [1, 10, 1009, 1028, 1040, 10408, 10410, 10630, 11, 110, 1113, 11499, 115, 11500, 116, 12, 1201, 1261, 1283, 13, 1306, 1400, 15, 1508, 1572, 16, 17, 178, 18, 180, 19, 2, 20, 200, 2031, 21, 22, 23, 230, 244, 26, 27, 273, 28, 281, 29, 30, 323, 3242, 326,...

# File:         process.rb | Line: 147
# Definition:   def stopped
LinuxStat::Process.stopped()
=> []

# File:         process.rb | Line: 78
# Definition:   def types
LinuxStat::Process.types()
=> {1=>:sleeping, 10=>:sleeping, 1009=>:sleeping, 101=>:idle, 102=>:idle, 10241=>:idle, 10247=>:idle, 1028=>:sleeping, 103=>:idle, 10396=>:idle, 1040=>:sleeping, 10408=>:sleeping, 10409=>:idle, 10410=>:sleeping, 105=>:idle, 10580=>:idle, 106=>:idle, 1063...

# File:         process.rb | Line: 129
# Definition:   def zombie
LinuxStat::Process.zombie()
=> []

```

### LinuxStat::ProcessInfo
```
# File:         process_info.rb | Line: 61
# Definition:   def cmdline(pid = $$)
LinuxStat::ProcessInfo.cmdline(pid)
=> "ruby exe/linuxstat.rb -md"

# File:         process_info.rb | Line: 87
# Definition:   def command_name(pid = $$)
LinuxStat::ProcessInfo.command_name(pid)
=> "ruby"

# File:         process_info.rb | Line: 610
# Definition:   def nproc(pid = $$)
LinuxStat::ProcessInfo.count_cpu(pid)
=> 4

# File:         process_info.rb | Line: 280
# Definition:   def cpu_stat(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.cpu_stat(pid:, sleep:)
=> {:cpu_usage=>0.0, :threads=>0, :last_executed_cpu=>0}

# File:         process_info.rb | Line: 621
# Definition:   def cpu_time(pid = $$)
LinuxStat::ProcessInfo.cpu_time(pid)
=> 0.41999998688697815

# File:         process_info.rb | Line: 636
# Definition:   def cpu_times(pid = $$)
LinuxStat::ProcessInfo.cpu_times(pid)
=> {:hour=>0, :minute=>0, :second=>0, :jiffy=>41}

# File:         process_info.rb | Line: 340
# Definition:   def cpu_usage(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.cpu_usage(pid:, sleep:)
=> 0.0

# File:         process_info.rb | Line: 450
# Definition:   def gid(pid = $$)
LinuxStat::ProcessInfo.gid(pid)
=> {:real=>0, :effective=>0, :saved_set=>0, :filesystem_uid=>0}

# File:         process_info.rb | Line: 416
# Definition:   def last_executed_cpu(pid = $$)
LinuxStat::ProcessInfo.last_executed_cpu(pid)
=> 1

# File:         process_info.rb | Line: 151
# Definition:   def mem_stat(pid = $$)
LinuxStat::ProcessInfo.mem_stat(pid)
=> {:memory=>26181632, :virtual_memory=>98832384, :resident_memory=>32468992, :shared_memory=>6287360}

# File:         process_info.rb | Line: 171
# Definition:   def memory(pid = $$)
LinuxStat::ProcessInfo.memory(pid)
=> 26181.632

# File:         process_info.rb | Line: 580
# Definition:   def nice(pid = $$)
LinuxStat::ProcessInfo.nice(pid)
=> 0

# File:         process_info.rb | Line: 610
# Definition:   def nproc(pid = $$)
LinuxStat::ProcessInfo.nproc(pid)
=> 4

# File:         process_info.rb | Line: 471
# Definition:   def owner(pid = $$)
LinuxStat::ProcessInfo.owner(pid)
=> "root"

# File:         process_info.rb | Line: 112
# Definition:   def process_name(pid = $$)
LinuxStat::ProcessInfo.process_name(pid)
=> "ruby"

# File:         process_info.rb | Line: 213
# Definition:   def resident_memory(pid = $$)
LinuxStat::ProcessInfo.resident_memory(pid)
=> 32468.992

# File:         process_info.rb | Line: 542
# Definition:   def running_time(pid = $$)
LinuxStat::ProcessInfo.running_time(pid)
=> 3.09

# File:         process_info.rb | Line: 234
# Definition:   def shared_memory(pid = $$)
LinuxStat::ProcessInfo.shared_memory(pid)
=> 6287.36

# File:         process_info.rb | Line: 521
# Definition:   def start_time(pid = $$)
LinuxStat::ProcessInfo.start_time(pid)
=> 2021-06-07 11:12:36 +0530

# File:         process_info.rb | Line: 493
# Definition:   def start_time_epoch(pid = $$)
LinuxStat::ProcessInfo.start_time_epoch(pid)
=> 1623044556

# File:         process_info.rb | Line: 567
# Definition:   def state(pid = $$)
LinuxStat::ProcessInfo.state(pid)
=> "R"

# File:         process_info.rb | Line: 370
# Definition:   def thread_usage(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.thread_usage(pid:, sleep:)
=> 0.0

# File:         process_info.rb | Line: 395
# Definition:   def threads(pid = $$)
LinuxStat::ProcessInfo.threads(pid)
=> 1

# File:         process_info.rb | Line: 30
# Definition:   def total_io(pid = $$)
LinuxStat::ProcessInfo.total_io(pid)
=> {:read_bytes=>0, :write_bytes=>0}

# File:         process_info.rb | Line: 426
# Definition:   def uid(pid = $$)
LinuxStat::ProcessInfo.uid(pid)
=> {:real=>0, :effective=>0, :saved_set=>0, :filesystem_uid=>0}

# File:         process_info.rb | Line: 192
# Definition:   def virtual_memory(pid = $$)
LinuxStat::ProcessInfo.virtual_memory(pid)
=> 98832.384

```

### LinuxStat::Swap
```
# File:         swap.rb | Line: 24
# Definition:   def any?
LinuxStat::Swap.any?()
=> true

# File:         swap.rb | Line: 85
# Definition:   def available
LinuxStat::Swap.available()
=> 4194300

# File:         swap.rb | Line: 74
# Definition:   def free
LinuxStat::Swap.free()
=> 4194300

# File:         swap.rb | Line: 10
# Definition:   def list
LinuxStat::Swap.list()
=> {"/dev/zram0"=>[:partition, 4194300, 0, -2]}

# File:         swap.rb | Line: 128
# Definition:   def percent_available
LinuxStat::Swap.percent_available()
=> 100.0

# File:         swap.rb | Line: 108
# Definition:   def percent_used
LinuxStat::Swap.percent_used()
=> 0.0

# File:         swap.rb | Line: 35
# Definition:   def stat
LinuxStat::Swap.stat()
=> {:total=>4194300, :used=>0, :available=>4194300, :percent_used=>0.0, :percent_available=>100.0}

# File:         swap.rb | Line: 63
# Definition:   def total
LinuxStat::Swap.total()
=> 4194300

# File:         swap.rb | Line: 99
# Definition:   def used
LinuxStat::Swap.used()
=> 0

```

### LinuxStat::Sysconf
```
LinuxStat::Sysconf.child_max()
=> 31026

LinuxStat::Sysconf.expr_nest_max()
=> 32

LinuxStat::Sysconf.get_euid()
=> 0

LinuxStat::Sysconf.get_gid()
=> 0

LinuxStat::Sysconf.get_login()
=> "sourav"

LinuxStat::Sysconf.get_uid()
=> 0

LinuxStat::Sysconf.get_user()
=> "sourav"

LinuxStat::Sysconf.hostname()
=> "archlinux"

LinuxStat::Sysconf.hostname_max()
=> 64

LinuxStat::Sysconf.line_max()
=> 2048

LinuxStat::Sysconf.login_name_max()
=> 256

LinuxStat::Sysconf.open_max()
=> 8192

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

### LinuxStat::Sysinfo
```
LinuxStat::Sysinfo.bufferram()
=> 2990080

LinuxStat::Sysinfo.freehigh()
=> 0

LinuxStat::Sysinfo.freeram()
=> 2358599680

LinuxStat::Sysinfo.freeswap()
=> 4294963200

LinuxStat::Sysinfo.loads()
=> [1.8173828125, 1.2158203125, 0.89794921875]

LinuxStat::Sysinfo.sharedram()
=> 713322496

LinuxStat::Sysinfo.stat()
=> {:totalram=>8151928832, :freeram=>2358599680, :sharedram=>713322496, :bufferram=>2990080, :totalswap=>4294963200, :freeswap=>4294963200, :totalhigh=>0, :freehigh=>0, :uptime=>9931, :loads=>[1.8173828125, 1.2158203125, 0.89794921875]}

LinuxStat::Sysinfo.totalhigh()
=> 0

LinuxStat::Sysinfo.totalram()
=> 8151928832

LinuxStat::Sysinfo.totalswap()
=> 4294963200

LinuxStat::Sysinfo.uptime()
=> 9931

```

### LinuxStat::Thermal
```
# File:         thermal.rb | Line: 59
# Definition:   def count_fans
LinuxStat::Thermal.count_fans()
=> 1

# File:         thermal.rb | Line: 49
# Definition:   def count_sensors
LinuxStat::Thermal.count_sensors()
=> 8

# File:         thermal.rb | Line: 41
# Definition:   def fans
LinuxStat::Thermal.fans()
=> [{:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"Processor Fan", :rpm=>2669}]

# File:         thermal.rb | Line: 23
# Definition:   def temperatures
LinuxStat::Thermal.temperatures()
=> [{:path=>"/sys/class/hwmon/hwmon1", :name=>"acpitz", :temperature=>25.0, :temp_crit=>107.0}, {:path=>"/sys/class/hwmon/hwmon3", :name=>"pch_skylake", :temperature=>45.0}, {:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"CPU", :temperatur...

```

### LinuxStat::USB
```
# File:         usb.rb | Line: 139
# Definition:   def count
LinuxStat::USB.count()
=> 14

# File:         usb.rb | Line: 139
# Definition:   def count
LinuxStat::USB.count_devices()
=> 14

# File:         usb.rb | Line: 49
# Definition:   def devices_stat(hwdata: true)
LinuxStat::USB.devices_stat(hwdata:)
=> [{:path=>"/sys/bus/usb/devices/1-1.3/", :id=>"0781:5567", :vendor_id=>"0781", :product_id=>"5567", :bus_num=>1, :dev_num=>15, :serial=>"4C530001290201115203", :hwdata=>{:vendor=>"SanDisk Corp.", :product=>"Cruzer Blade"}, :product=>"Cruzer Blade", :ma...

# File:         usb.rb | Line: 179
# Definition:   def hwdata_file
LinuxStat::USB.hwdata_file()
=> "/usr/share/hwdata/usb.ids"

# File:         usb.rb | Line: 168
# Definition:   def hwdata_file_set?
LinuxStat::USB.hwdata_file_set?()
=> true

# File:         usb.rb | Line: 195
# Definition:   def initialize_hwdata
LinuxStat::USB.initialize_hwdata()
=> false

```

### LinuxStat::Uname
```
LinuxStat::Uname.machine()
=> "x86_64"

LinuxStat::Uname.nodename()
=> "archlinux"

LinuxStat::Uname.release()
=> "5.12.8-xanmod1-cacule-1-cacule"

LinuxStat::Uname.sysname()
=> "Linux"

LinuxStat::Uname.version()
=> "#1 SMP PREEMPT Fri, 28 May 2021 23:08:03 +0000"

```

### LinuxStat::User
```
# File:         user.rb | Line: 101
# Definition:   def get_user
LinuxStat::User.get_current_user()
=> "root"

# File:         user.rb | Line: 140
# Definition:   def get_euid
LinuxStat::User.get_euid()
=> 0

# File:         user.rb | Line: 132
# Definition:   def get_gid
LinuxStat::User.get_gid()
=> 0

# File:         user.rb | Line: 155
# Definition:   def get_login
LinuxStat::User.get_login()
=> "sourav"

# File:         user.rb | Line: 124
# Definition:   def get_uid
LinuxStat::User.get_uid()
=> 0

# File:         user.rb | Line: 101
# Definition:   def get_user
LinuxStat::User.get_user()
=> "root"

# File:         user.rb | Line: 218
# Definition:   def gid_by_username(username = get_user)
LinuxStat::User.gid_by_username(username)
=> 0

# File:         user.rb | Line: 58
# Definition:   def gids
LinuxStat::User.gids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>12, :ftp=>11, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :...

# File:         user.rb | Line: 317
# Definition:   def home_by_gid(id = get_gid)
LinuxStat::User.home_by_gid(id)
=> "/root"

# File:         user.rb | Line: 269
# Definition:   def home_by_username(user = get_user)
LinuxStat::User.home_by_username(user)
=> "/root"

# File:         user.rb | Line: 75
# Definition:   def home_directories
LinuxStat::User.home_directories()
=> {:root=>"/root", :bin=>"/", :daemon=>"/", :mail=>"/var/spool/mail", :ftp=>"/srv/ftp", :http=>"/srv/http", :nobody=>"/", :dbus=>"/", :"systemd-journal-remote"=>"/", :"systemd-network"=>"/", :"systemd-resolve"=>"/", :"systemd-timesync"=>"/", :"systemd-c...

# File:         user.rb | Line: 296
# Definition:   def homes_by_uid(id = get_uid)
LinuxStat::User.homes_by_uid(id)
=> ["/root"]

# File:         user.rb | Line: 25
# Definition:   def ids
LinuxStat::User.ids()
=> {:root=>{:uid=>0, :gid=>0}, :bin=>{:uid=>1, :gid=>1}, :daemon=>{:uid=>2, :gid=>2}, :mail=>{:uid=>8, :gid=>12}, :ftp=>{:uid=>14, :gid=>11}, :http=>{:uid=>33, :gid=>33}, :nobody=>{:uid=>65534, :gid=>65534}, :dbus=>{:uid=>81, :gid=>81}, :"systemd-journal...

# File:         user.rb | Line: 13
# Definition:   def list
LinuxStat::User.list()
=> ["root", "bin", "daemon", "mail", "ftp", "http", "nobody", "dbus", "systemd-journal-remote", "systemd-network", "systemd-resolve", "systemd-timesync", "systemd-coredump", "uuidd", "avahi", "colord", "git", "lxdm", "polkitd", "rtkit", "usbmux", "sourav...

# File:         user.rb | Line: 247
# Definition:   def uid_by_username(username = get_user)
LinuxStat::User.uid_by_username(username)
=> 0

# File:         user.rb | Line: 42
# Definition:   def uids
LinuxStat::User.uids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>8, :ftp=>14, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :c...

# File:         user.rb | Line: 190
# Definition:   def username_by_gid(gid = get_gid)
LinuxStat::User.username_by_gid(gid)
=> "root"

# File:         user.rb | Line: 172
# Definition:   def usernames_by_uid(uid = get_uid)
LinuxStat::User.usernames_by_uid(uid)
=> ["root"]

```
