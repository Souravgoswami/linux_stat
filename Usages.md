### LinuxStat::BIOS
```
# File:		bios.rb | Line: 58
# Definition:	def date
LinuxStat::BIOS.date()
=> "04/10/2017"

# File:		bios.rb | Line: 12
# Definition:	def model
LinuxStat::BIOS.model()
=> "Inspiron 5567"

# File:		bios.rb | Line: 29
# Definition:	def vendor
LinuxStat::BIOS.vendor()
=> "Dell Inc."

# File:		bios.rb | Line: 44
# Definition:	def version
LinuxStat::BIOS.version()
=> "1.1.2"

```

### LinuxStat::Battery
```
# File:		battery.rb | Line: 107
# Definition:	def charge
LinuxStat::Battery.charge()
=> 100.0

# File:		battery.rb | Line: 124
# Definition:	def charge_full_design_wh
LinuxStat::Battery.charge_full_design_wh()
=> 42.0

# File:		battery.rb | Line: 143
# Definition:	def charge_full_wh
LinuxStat::Battery.charge_full_wh()
=> 23.79

# File:		battery.rb | Line: 80
# Definition:	def charging?
LinuxStat::Battery.charging?()
=> true

# File:		battery.rb | Line: 193
# Definition:	def devices_stat
LinuxStat::Battery.devices_stat()
=> {:AC=>{:type=>"Mains", :online=>1}, :BAT0=>{:model=>"DELL CYMGM77", :manufacturer=>"Samsung SDI", :type=>"Battery", :status=>"Full", :capacity=>100, :voltage_min_design=>11.4, :charge_full_design=>3.684, :charge_full_design_wh=>42.0, :voltage_now=>12....

# File:		battery.rb | Line: 89
# Definition:	def discharging?
LinuxStat::Battery.discharging?()
=> false

# File:		battery.rb | Line: 98
# Definition:	def full?
LinuxStat::Battery.full?()
=> true

# File:		battery.rb | Line: 49
# Definition:	def manufacturer
LinuxStat::Battery.manufacturer()
=> "Samsung SDI"

# File:		battery.rb | Line: 38
# Definition:	def model
LinuxStat::Battery.model()
=> "DELL CYMGM77"

# File:		battery.rb | Line: 10
# Definition:	def present?
LinuxStat::Battery.present?()
=> true

# File:		battery.rb | Line: 18
# Definition:	def stat
LinuxStat::Battery.stat()
=> {:model=>"DELL CYMGM77", :manufacturer=>"Samsung SDI", :technology=>"Li-ion", :status=>"Full", :charge=>100.0, :charging=>true, :discharging=>false, :full=>true}

# File:		battery.rb | Line: 70
# Definition:	def status
LinuxStat::Battery.status()
=> "Full"

# File:		battery.rb | Line: 59
# Definition:	def technology
LinuxStat::Battery.technology()
=> "Li-ion"

# File:		battery.rb | Line: 162
# Definition:	def voltage_now
LinuxStat::Battery.voltage_now()
=> 12.531

```

### LinuxStat::CPU
```
# File:		cpu.rb | Line: 289
# Definition:	def available_governors
LinuxStat::CPU.available_governors()
=> {"cpu0"=>["performance", "powersave"], "cpu1"=>["performance", "powersave"], "cpu2"=>["performance", "powersave"], "cpu3"=>["performance", "powersave"]}

# File:		cpu.rb | Line: 88
# Definition:	def count
LinuxStat::CPU.count()
=> 4

# File:		cpu.rb | Line: 105
# Definition:	def count_online
LinuxStat::CPU.count_online()
=> 4

# File:		cpu.rb | Line: 199
# Definition:	def cur_freq
LinuxStat::CPU.cur_freq()
=> {"cpu0"=>1969861, "cpu1"=>2000059, "cpu2"=>2000024, "cpu3"=>1949778}

# File:		cpu.rb | Line: 267
# Definition:	def governor
LinuxStat::CPU.governor()
=> {"cpu0"=>"performance", "cpu1"=>"performance", "cpu2"=>"performance", "cpu3"=>"performance"}

# File:		cpu.rb | Line: 243
# Definition:	def max_freq
LinuxStat::CPU.max_freq()
=> {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}

# File:		cpu.rb | Line: 221
# Definition:	def min_freq
LinuxStat::CPU.min_freq()
=> {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}

# File:		cpu.rb | Line: 186
# Definition:	def model
LinuxStat::CPU.model()
=> "Intel(R) Core(TM) i3-6006U CPU @ 2.00GHz"

# File:		cpu.rb | Line: 165
# Definition:	def offline
LinuxStat::CPU.offline()
=> []

# File:		cpu.rb | Line: 134
# Definition:	def online
LinuxStat::CPU.online()
=> [0, 1, 2, 3]

# File:		cpu.rb | Line: 25
# Definition:	def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.stat(sleep)
=> {0=>9.52, 1=>16.67, 2=>20.0, 3=>0.0, 4=>16.67}

# File:		cpu.rb | Line: 65
# Definition:	def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.total_usage(sleep)
=> 5.56

# File:		cpu.rb | Line: 65
# Definition:	def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usage(sleep)
=> 5.0

# File:		cpu.rb | Line: 25
# Definition:	def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usages(sleep)
=> {0=>10.0, 1=>0.0, 2=>0.0, 3=>0.0, 4=>0.0}

```

### LinuxStat::FS
```
LinuxStat::FS.stat(arg = "/")
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>7498564, :block_avail_unpriv=>7498564, :inodes=>58612160, :free_inodes=>56765394, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

```

### LinuxStat::Filesystem
```
# File:		filesystem.rb | Line: 94
# Definition:	def available(fs = ?..freeze)
LinuxStat::Filesystem.available(fs)
=> 30714118144

# File:		filesystem.rb | Line: 60
# Definition:	def free(fs = ?..freeze)
LinuxStat::Filesystem.free(fs)
=> 30714118144

# File:		filesystem.rb | Line: 21
# Definition:	def stat(fs = ?..freeze)
LinuxStat::Filesystem.stat(fs)
=> {:total=>119981191168, :free=>30714118144, :used=>89267073024}

# File:		filesystem.rb | Line: 110
# Definition:	def stat_raw(fs = ?..freeze)
LinuxStat::Filesystem.stat_raw(fs)
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29292283, :block_free=>7498564, :block_avail_unpriv=>7498564, :inodes=>58612160, :free_inodes=>56765394, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

# File:		filesystem.rb | Line: 41
# Definition:	def total(fs = ?..freeze)
LinuxStat::Filesystem.total(fs)
=> 119981191168

# File:		filesystem.rb | Line: 75
# Definition:	def used(fs = ?..freeze)
LinuxStat::Filesystem.used(fs)
=> 89267073024

```

### LinuxStat::Kernel
```
# File:		kernel.rb | Line: 88
# Definition:	def build_date
LinuxStat::Kernel.build_date()
=> 2020-11-20 07:44:55 +0000

# File:		kernel.rb | Line: 142
# Definition:	def build_date_string
LinuxStat::Kernel.build_date_string()
=> "20 Nov 2020 07:44:55 +0000"

# File:		kernel.rb | Line: 23
# Definition:	def build_user
LinuxStat::Kernel.build_user()
=> "souravgoswami@archlinux"

# File:		kernel.rb | Line: 181
# Definition:	def ticks
LinuxStat::Kernel.clk_tck()
=> 100

# File:		kernel.rb | Line: 35
# Definition:	def compiler
LinuxStat::Kernel.compiler()
=> [:gcc, "10.2.0"]

# File:		kernel.rb | Line: 57
# Definition:	def compiler_version
LinuxStat::Kernel.compiler_version()
=> "10.2.0"

# File:		kernel.rb | Line: 12
# Definition:	def version
LinuxStat::Kernel.release()
=> "5.9.9-xanmod1-1"

# File:		kernel.rb | Line: 171
# Definition:	def string
LinuxStat::Kernel.string()
=> "Linux version 5.9.9-xanmod1-1 (souravgoswami@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 SMP PREEMPT Fri, 20 Nov 2020 07:44:55 +0000"

# File:		kernel.rb | Line: 181
# Definition:	def ticks
LinuxStat::Kernel.ticks()
=> 100

# File:		kernel.rb | Line: 12
# Definition:	def version
LinuxStat::Kernel.version()
=> "5.9.9-xanmod1-1"

```

### LinuxStat::Memory
```
# File:		memory.rb | Line: 62
# Definition:	def available
LinuxStat::Memory.available()
=> 595616

# File:		memory.rb | Line: 52
# Definition:	def free
LinuxStat::Memory.free()
=> 256356

# File:		memory.rb | Line: 93
# Definition:	def percent_available
LinuxStat::Memory.percent_available()
=> 15.53

# File:		memory.rb | Line: 82
# Definition:	def percent_used
LinuxStat::Memory.percent_used()
=> 84.47

# File:		memory.rb | Line: 13
# Definition:	def stat
LinuxStat::Memory.stat()
=> {:total=>3836228, :used=>3240612, :available=>595616, :percent_used=>84.47, :percent_available=>15.53}

# File:		memory.rb | Line: 42
# Definition:	def total
LinuxStat::Memory.total()
=> 3836228

# File:		memory.rb | Line: 72
# Definition:	def used
LinuxStat::Memory.used()
=> 3240620

```

### LinuxStat::Mounts
```
# File:		mounts.rb | Line: 181
# Definition:	def device_stat(dev = root)
LinuxStat::Mounts.device_stat(dev)
=> {:mountpoint=>"/", :total=>119981191168, :free=>30714118144, :available=>30714118144, :used=>89267073024, :percent_used=>74.4, :percent_free=>25.6, :percent_available=>25.6}

# File:		mounts.rb | Line: 139
# Definition:	def devices_stat
LinuxStat::Mounts.devices_stat()
=> {"proc"=>{:mountpoint=>"/proc", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_free=>NaN, :percent_available=>NaN}, "sys"=>{:mountpoint=>"/sys", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_fre...

# File:		mounts.rb | Line: 13
# Definition:	def list
LinuxStat::Mounts.list()
=> ["proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0", "sys /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0", "dev /dev devtmpfs rw,nosuid,relatime,size=1892888k,nr_inodes=473222,mode=755 0 0", "run /run tmpfs rw,nosuid,nodev,relatime,mode=755 0 0", "...

# File:		mounts.rb | Line: 22
# Definition:	def list_devices
LinuxStat::Mounts.list_devices()
=> ["proc", "sys", "dev", "run", "/dev/sda2", "securityfs", "tmpfs", "devpts", "tmpfs", "cgroup2", "cgroup", "pstore", "none", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "cgroup", "systemd-1", "deb...

# File:		mounts.rb | Line: 111
# Definition:	def list_devices_mount_point
LinuxStat::Mounts.list_devices_mount_point()
=> {"proc"=>"/proc", "sys"=>"/sys", "dev"=>"/dev", "run"=>"/run", "/dev/sda2"=>"/", "securityfs"=>"/sys/kernel/security", "tmpfs"=>"/run/user/1000", "devpts"=>"/dev/pts", "cgroup2"=>"/sys/fs/cgroup/unified", "cgroup"=>"/sys/fs/cgroup/rdma", "pstore"=>"/s...

# File:		mounts.rb | Line: 82
# Definition:	def mount_point(dev = root)
LinuxStat::Mounts.mount_point(dev)
=> "/"

# File:		mounts.rb | Line: 31
# Definition:	def root
LinuxStat::Mounts.root()
=> "/dev/sda2"

# File:		mounts.rb | Line: 40
# Definition:	def root_fs
LinuxStat::Mounts.root_fs()
=> "xfs"

# File:		mounts.rb | Line: 49
# Definition:	def root_mount_options
LinuxStat::Mounts.root_mount_options()
=> "rw,noatime,attr2,inode64,logbufs=8,logbsize=32k,noquota"

# File:		mounts.rb | Line: 58
# Definition:	def tmpfs
LinuxStat::Mounts.tmpfs()
=> {"/dev/shm"=>"tmpfs /dev/shm tmpfs rw,nosuid,nodev 0 0", "/sys/fs/cgroup"=>"tmpfs /sys/fs/cgroup tmpfs ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755 0 0", "/ramdisk"=>"tmpfs /ramdisk tmpfs rw,nosuid,nodev,relatime,size=6291456k 0 0", "/tmp...

```

### LinuxStat::Net
```
# File:		net.rb | Line: 86
# Definition:	def usage(interval = 0.1)
LinuxStat::Net.current_usage(interval)
=> {:received=>0.0, :transmitted=>0.0}

# File:		net.rb | Line: 12
# Definition:	def ipv4_private
LinuxStat::Net.ipv4_private()
=> "192.168.0.103"

# File:		net.rb | Line: 27
# Definition:	def total_bytes
LinuxStat::Net.total_bytes()
=> {:received=>2371748196, :transmitted=>220748232}

# File:		net.rb | Line: 45
# Definition:	def total_bytes_received
LinuxStat::Net.total_bytes_received()
=> 2371748196

# File:		net.rb | Line: 58
# Definition:	def total_bytes_transmitted
LinuxStat::Net.total_bytes_transmitted()
=> 220748232

# File:		net.rb | Line: 86
# Definition:	def usage(interval = 0.1)
LinuxStat::Net.usage(interval)
=> {:received=>820.0, :transmitted=>0.0}

```

### LinuxStat::OS
```
# File:		os.rb | Line: 133
# Definition:	def bits
LinuxStat::OS.bits()
=> 64

# File:		os.rb | Line: 88
# Definition:	def version
LinuxStat::OS.distrib_version()
=> "rolling"

# File:		os.rb | Line: 50
# Definition:	def distribution
LinuxStat::OS.distribution()
=> "Arch Linux"

# File:		os.rb | Line: 121
# Definition:	def hostname
LinuxStat::OS.hostname()
=> "archlinux"

# File:		os.rb | Line: 208
# Definition:	def loadavg
LinuxStat::OS.loadavg()
=> {1=>2.873046875, 5=>1.9189453125, 15=>1.396484375}

# File:		os.rb | Line: 39
# Definition:	def lsb_release
LinuxStat::OS.lsb_release()
=> {:LSB_VERSION=>"1.4", :DISTRIB_ID=>"Arch", :DISTRIB_RELEASE=>"rolling", :DISTRIB_DESCRIPTION=>"Arch Linux"}

# File:		os.rb | Line: 104
# Definition:	def machine
LinuxStat::OS.machine()
=> "x86_64"

# File:		os.rb | Line: 112
# Definition:	def nodename
LinuxStat::OS.nodename()
=> "archlinux"

# File:		os.rb | Line: 23
# Definition:	def os_release
LinuxStat::OS.os_release()
=> {:NAME=>"Arch Linux", :PRETTY_NAME=>"Arch Linux", :ID=>"arch", :BUILD_ID=>"rolling", :ANSI_COLOR=>"38;2;23;147;209", :HOME_URL=>"https://www.archlinux.org/", :DOCUMENTATION_URL=>"https://wiki.archlinux.org/", :SUPPORT_URL=>"https://bbs.archlinux.org/"...

# File:		os.rb | Line: 150
# Definition:	def uptime
LinuxStat::OS.uptime()
=> {:hour=>16, :minute=>16, :second=>1, :jiffy=>43}

# File:		os.rb | Line: 180
# Definition:	def uptime_f
LinuxStat::OS.uptime_f()
=> 58561.43

# File:		os.rb | Line: 191
# Definition:	def uptime_i
LinuxStat::OS.uptime_i()
=> 58562

# File:		os.rb | Line: 88
# Definition:	def version
LinuxStat::OS.version()
=> "rolling"

```

### LinuxStat::PCI
```
# File:		pci.rb | Line: 216
# Definition:	def count
LinuxStat::PCI.count()
=> 13

# File:		pci.rb | Line: 216
# Definition:	def count
LinuxStat::PCI.count_devices()
=> 13

# File:		pci.rb | Line: 54
# Definition:	def devices_info(hwdata: true)
LinuxStat::PCI.devices_info(hwdata:)
=> [{:id=>"8086:1904", :vendor=>"8086", :device=>"1904", :irq=>0, :kernel_driver=>"skl_uncore", :hwdata=>{:vendor=>"Intel Corporation", :product=>"Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers"}}, {:id=>"8086:1916", :vendor...

# File:		pci.rb | Line: 130
# Definition:	def devices_stat(hwdata: true)
LinuxStat::PCI.devices_stat(hwdata:)
=> [{:path=>"/sys/bus/pci/devices/0000:00:00.0/", :id=>"8086:1904", :vendor=>"8086", :device=>"1904", :sub_vendor=>"1028", :sub_device=>"077d", :kernel_driver=>"skl_uncore", :revision=>"0x08", :irq=>0, :enable=>false, :hwdata=>{:vendor=>"Intel Corporatio...

# File:		pci.rb | Line: 264
# Definition:	def hwdata_file
LinuxStat::PCI.hwdata_file()
=> "/usr/share/hwdata/pci.ids"

# File:		pci.rb | Line: 253
# Definition:	def hwdata_file_set?
LinuxStat::PCI.hwdata_file_set?()
=> true

# File:		pci.rb | Line: 280
# Definition:	def initialize_hwdata
LinuxStat::PCI.initialize_hwdata()
=> false

```

### LinuxStat::PrettifyBytes
```
# File:		prettify_bytes.rb | Line: 49
# Definition:	def convert_binary(n, precision: 2)
LinuxStat::PrettifyBytes.convert_binary(n = 55206562261629, precision:)
=> "50.21 tebibytes"

# File:		prettify_bytes.rb | Line: 26
# Definition:	def convert_decimal(n, precision: 2)
LinuxStat::PrettifyBytes.convert_decimal(n = 341141363483637, precision:)
=> "341.14 terabytes"

# File:		prettify_bytes.rb | Line: 97
# Definition:	def convert_short_binary(n, precision: 2)
LinuxStat::PrettifyBytes.convert_short_binary(n = 175331196815015, precision:)
=> "159.46 TiB"

# File:		prettify_bytes.rb | Line: 72
# Definition:	def convert_short_decimal(n, precision: 2)
LinuxStat::PrettifyBytes.convert_short_decimal(n = 789625492086030, precision:)
=> "789.63 TB"

```

### LinuxStat::ProcFS
```
LinuxStat::ProcFS.last_pid()
=> 52438

LinuxStat::ProcFS.uptime_f()
=> 58561.65

```

### LinuxStat::Process
```
# File:		process.rb | Line: 57
# Definition:	def cmdlines
LinuxStat::Process.cmdlines()
=> {1=>"/usr/lib/systemd/systemd --system --deserialize 63", 2=>"", 3=>"", 4=>"", 6=>"", 9=>"", 10=>"", 11=>"", 12=>"", 13=>"", 14=>"", 15=>"", 16=>"", 17=>"", 18=>"", 19=>"", 20=>"", 21=>"", 23=>"", 24=>"", 25=>"", 26=>"", 27=>"", 28=>"", 30=>"", 31=>""...

# File:		process.rb | Line: 29
# Definition:	def count
LinuxStat::Process.count()
=> 212

# File:		process.rb | Line: 120
# Definition:	def idle
LinuxStat::Process.idle()
=> [3, 4, 6, 9, 12, 23, 30, 37, 39, 49, 102, 103, 104, 106, 107, 108, 109, 110, 117, 118, 119, 121, 131, 134, 140, 165, 168, 170, 171, 175, 180, 181, 182, 183, 184, 185, 186, 187, 189, 231, 234, 275, 447, 502, 21751, 23896, 41972, 41973, 41974, 41975, 41...

# File:		process.rb | Line: 160
# Definition:	def last_pid
LinuxStat::Process.last_pid()
=> 52438

# File:		process.rb | Line: 11
# Definition:	def list
LinuxStat::Process.list()
=> [1, 2, 3, 4, 6, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 42, 46, 47, 48, 49, 50, 51, 52, 102, 103, 104, 106, 107, 108, 109, 110, 112, 114, 115, 117, 118, 119, 121, 131, 134,...

# File:		process.rb | Line: 36
# Definition:	def names
LinuxStat::Process.names()
=> {1=>"systemd", 2=>"kthreadd", 3=>"rcu_gp", 4=>"rcu_par_gp", 6=>"kworker/0:0H-kblockd", 9=>"mm_percpu_wq", 10=>"ksoftirqd/0", 11=>"rcuc/0", 12=>"rcu_preempt", 13=>"rcub/0", 14=>"migration/0", 15=>"idle_inject/0", 16=>"cpuhp/0", 17=>"cpuhp/1", 18=>"idle...

# File:		process.rb | Line: 138
# Definition:	def running
LinuxStat::Process.running()
=> [52438]

# File:		process.rb | Line: 111
# Definition:	def sleeping
LinuxStat::Process.sleeping()
=> [1, 2, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 38, 40, 41, 42, 46, 47, 48, 50, 51, 52, 112, 114, 115, 164, 167, 188, 218, 233, 235, 308, 311, 362, 364, 365, 378, 379, 380, 381, 395, 398, 401, 465, 520, 522,...

# File:		process.rb | Line: 147
# Definition:	def stopped
LinuxStat::Process.stopped()
=> []

# File:		process.rb | Line: 78
# Definition:	def types
LinuxStat::Process.types()
=> {1=>:sleeping, 2=>:sleeping, 3=>:idle, 4=>:idle, 6=>:idle, 9=>:idle, 10=>:sleeping, 11=>:sleeping, 12=>:idle, 13=>:sleeping, 14=>:sleeping, 15=>:sleeping, 16=>:sleeping, 17=>:sleeping, 18=>:sleeping, 19=>:sleeping, 20=>:sleeping, 21=>:sleeping, 23=>:i...

# File:		process.rb | Line: 129
# Definition:	def zombie
LinuxStat::Process.zombie()
=> []

```

### LinuxStat::ProcessInfo
```
# File:		process_info.rb | Line: 61
# Definition:	def cmdline(pid = $$)
LinuxStat::ProcessInfo.cmdline(pid)
=> "/usr/bin/ruby /home/sourav/.gem/ruby/2.7.0/bin/linuxstat.rb --markdown"

# File:		process_info.rb | Line: 87
# Definition:	def command_name(pid = $$)
LinuxStat::ProcessInfo.command_name(pid)
=> "ruby"

# File:		process_info.rb | Line: 608
# Definition:	def nproc(pid = $$)
LinuxStat::ProcessInfo.count_cpu(pid)
=> 4

# File:		process_info.rb | Line: 280
# Definition:	def cpu_stat(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.cpu_stat(pid:, sleep:)
=> {:cpu_usage=>0.0, :threads=>0, :last_executed_cpu=>0}

# File:		process_info.rb | Line: 619
# Definition:	def cpu_time(pid = $$)
LinuxStat::ProcessInfo.cpu_time(pid)
=> 0.4399999976158142

# File:		process_info.rb | Line: 634
# Definition:	def cpu_times(pid = $$)
LinuxStat::ProcessInfo.cpu_times(pid)
=> {:hour=>0, :minute=>0, :second=>0, :jiffy=>43}

# File:		process_info.rb | Line: 340
# Definition:	def cpu_usage(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.cpu_usage(pid:, sleep:)
=> 0.0

# File:		process_info.rb | Line: 450
# Definition:	def gid(pid = $$)
LinuxStat::ProcessInfo.gid(pid)
=> {:real=>1000, :effective=>1000, :saved_set=>1000, :filesystem_uid=>1000}

# File:		process_info.rb | Line: 416
# Definition:	def last_executed_cpu(pid = $$)
LinuxStat::ProcessInfo.last_executed_cpu(pid)
=> 3

# File:		process_info.rb | Line: 151
# Definition:	def mem_stat(pid = $$)
LinuxStat::ProcessInfo.mem_stat(pid)
=> {:memory=>24735744, :virtual_memory=>96317440, :resident_memory=>30707712, :shared_memory=>5971968}

# File:		process_info.rb | Line: 171
# Definition:	def memory(pid = $$)
LinuxStat::ProcessInfo.memory(pid)
=> 24735.744

# File:		process_info.rb | Line: 578
# Definition:	def nice(pid = $$)
LinuxStat::ProcessInfo.nice(pid)
=> 0

# File:		process_info.rb | Line: 608
# Definition:	def nproc(pid = $$)
LinuxStat::ProcessInfo.nproc(pid)
=> 4

# File:		process_info.rb | Line: 471
# Definition:	def owner(pid = $$)
LinuxStat::ProcessInfo.owner(pid)
=> "sourav"

# File:		process_info.rb | Line: 112
# Definition:	def process_name(pid = $$)
LinuxStat::ProcessInfo.process_name(pid)
=> "linuxstat.rb"

# File:		process_info.rb | Line: 213
# Definition:	def resident_memory(pid = $$)
LinuxStat::ProcessInfo.resident_memory(pid)
=> 30707.712

# File:		process_info.rb | Line: 540
# Definition:	def running_time(pid = $$)
LinuxStat::ProcessInfo.running_time(pid)
=> 1.03

# File:		process_info.rb | Line: 234
# Definition:	def shared_memory(pid = $$)
LinuxStat::ProcessInfo.shared_memory(pid)
=> 5971.968

# File:		process_info.rb | Line: 521
# Definition:	def start_time(pid = $$)
LinuxStat::ProcessInfo.start_time(pid)
=> 2021-02-07 03:30:35 +0530

# File:		process_info.rb | Line: 493
# Definition:	def start_time_epoch(pid = $$)
LinuxStat::ProcessInfo.start_time_epoch(pid)
=> 1612648835

# File:		process_info.rb | Line: 565
# Definition:	def state(pid = $$)
LinuxStat::ProcessInfo.state(pid)
=> "R"

# File:		process_info.rb | Line: 370
# Definition:	def thread_usage(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.thread_usage(pid:, sleep:)
=> 0.0

# File:		process_info.rb | Line: 395
# Definition:	def threads(pid = $$)
LinuxStat::ProcessInfo.threads(pid)
=> 1

# File:		process_info.rb | Line: 30
# Definition:	def total_io(pid = $$)
LinuxStat::ProcessInfo.total_io(pid)
=> {:read_bytes=>1286144, :write_bytes=>0}

# File:		process_info.rb | Line: 426
# Definition:	def uid(pid = $$)
LinuxStat::ProcessInfo.uid(pid)
=> {:real=>1000, :effective=>1000, :saved_set=>1000, :filesystem_uid=>1000}

# File:		process_info.rb | Line: 192
# Definition:	def virtual_memory(pid = $$)
LinuxStat::ProcessInfo.virtual_memory(pid)
=> 96317.44

```

### LinuxStat::Swap
```
# File:		swap.rb | Line: 24
# Definition:	def any?
LinuxStat::Swap.any?()
=> true

# File:		swap.rb | Line: 84
# Definition:	def available
LinuxStat::Swap.available()
=> 2328956

# File:		swap.rb | Line: 73
# Definition:	def free
LinuxStat::Swap.free()
=> 2328956

# File:		swap.rb | Line: 10
# Definition:	def list
LinuxStat::Swap.list()
=> {"/dev/zram0"=>[:partition, 4194300, 1865344, -2]}

# File:		swap.rb | Line: 127
# Definition:	def percent_available
LinuxStat::Swap.percent_available()
=> 55.53

# File:		swap.rb | Line: 107
# Definition:	def percent_used
LinuxStat::Swap.percent_used()
=> 44.47

# File:		swap.rb | Line: 34
# Definition:	def stat
LinuxStat::Swap.stat()
=> {:total=>4194300, :used=>1865344, :available=>2328956, :percent_used=>44.47, :percent_available=>55.53}

# File:		swap.rb | Line: 62
# Definition:	def total
LinuxStat::Swap.total()
=> 4194300

# File:		swap.rb | Line: 98
# Definition:	def used
LinuxStat::Swap.used()
=> 1865344

```

### LinuxStat::Sysconf
```
LinuxStat::Sysconf.child_max()
=> 14788

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

LinuxStat::Sysconf.hostname()
=> "archlinux"

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

### LinuxStat::Sysinfo
```
LinuxStat::Sysinfo.bufferram()
=> 4096

LinuxStat::Sysinfo.freehigh()
=> 0

LinuxStat::Sysinfo.freeram()
=> 258519040

LinuxStat::Sysinfo.freeswap()
=> 2384850944

LinuxStat::Sysinfo.loads()
=> [2.873046875, 1.9189453125, 1.396484375]

LinuxStat::Sysinfo.sharedram()
=> 644231168

LinuxStat::Sysinfo.stat()
=> {:totalram=>3928297472, :freeram=>258519040, :sharedram=>644231168, :bufferram=>4096, :totalswap=>4294963200, :freeswap=>2384850944, :totalhigh=>0, :freehigh=>0, :uptime=>58562, :loads=>[2.873046875, 1.9189453125, 1.396484375]}

LinuxStat::Sysinfo.totalhigh()
=> 0

LinuxStat::Sysinfo.totalram()
=> 3928297472

LinuxStat::Sysinfo.totalswap()
=> 4294963200

LinuxStat::Sysinfo.uptime()
=> 58562

```

### LinuxStat::Thermal
```
# File:		thermal.rb | Line: 59
# Definition:	def count_fans
LinuxStat::Thermal.count_fans()
=> 1

# File:		thermal.rb | Line: 49
# Definition:	def count_sensors
LinuxStat::Thermal.count_sensors()
=> 8

# File:		thermal.rb | Line: 41
# Definition:	def fans
LinuxStat::Thermal.fans()
=> [{:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"Processor Fan", :rpm=>2795}]

# File:		thermal.rb | Line: 23
# Definition:	def temperatures
LinuxStat::Thermal.temperatures()
=> [{:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"SODIMM", :temperature=>33.0}, {:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"CPU", :temperature=>41.0}, {:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"Ambi...

```

### LinuxStat::USB
```
# File:		usb.rb | Line: 139
# Definition:	def count
LinuxStat::USB.count()
=> 11

# File:		usb.rb | Line: 139
# Definition:	def count
LinuxStat::USB.count_devices()
=> 11

# File:		usb.rb | Line: 49
# Definition:	def devices_stat(hwdata: true)
LinuxStat::USB.devices_stat(hwdata:)
=> [{:path=>"/sys/bus/usb/devices/1-1.2/", :id=>"04d9:1203", :vendor_id=>"04d9", :product_id=>"1203", :bus_num=>1, :dev_num=>12, :hwdata=>{:vendor=>"Holtek Semiconductor, Inc.", :product=>"Keyboard"}, :authorized=>true, :b_max_power=>"100mA", :b_max_pack...

# File:		usb.rb | Line: 179
# Definition:	def hwdata_file
LinuxStat::USB.hwdata_file()
=> "/usr/share/hwdata/usb.ids"

# File:		usb.rb | Line: 168
# Definition:	def hwdata_file_set?
LinuxStat::USB.hwdata_file_set?()
=> true

# File:		usb.rb | Line: 195
# Definition:	def initialize_hwdata
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
=> "5.9.9-xanmod1-1"

LinuxStat::Uname.sysname()
=> "Linux"

LinuxStat::Uname.version()
=> "#1 SMP PREEMPT Fri, 20 Nov 2020 07:44:55 +0000"

```

### LinuxStat::User
```
# File:		user.rb | Line: 101
# Definition:	def get_user
LinuxStat::User.get_current_user()
=> "sourav"

# File:		user.rb | Line: 140
# Definition:	def get_euid
LinuxStat::User.get_euid()
=> 1000

# File:		user.rb | Line: 132
# Definition:	def get_gid
LinuxStat::User.get_gid()
=> 1000

# File:		user.rb | Line: 155
# Definition:	def get_login
LinuxStat::User.get_login()
=> "sourav"

# File:		user.rb | Line: 124
# Definition:	def get_uid
LinuxStat::User.get_uid()
=> 1000

# File:		user.rb | Line: 101
# Definition:	def get_user
LinuxStat::User.get_user()
=> "sourav"

# File:		user.rb | Line: 218
# Definition:	def gid_by_username(username = get_user)
LinuxStat::User.gid_by_username(username)
=> 1000

# File:		user.rb | Line: 58
# Definition:	def gids
LinuxStat::User.gids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>12, :ftp=>11, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :...

# File:		user.rb | Line: 317
# Definition:	def home_by_gid(id = get_gid)
LinuxStat::User.home_by_gid(id)
=> "/home/sourav"

# File:		user.rb | Line: 269
# Definition:	def home_by_username(user = get_user)
LinuxStat::User.home_by_username(user)
=> "/home/sourav"

# File:		user.rb | Line: 75
# Definition:	def home_directories
LinuxStat::User.home_directories()
=> {:root=>"/root", :bin=>"/", :daemon=>"/", :mail=>"/var/spool/mail", :ftp=>"/srv/ftp", :http=>"/srv/http", :nobody=>"/", :dbus=>"/", :"systemd-journal-remote"=>"/", :"systemd-network"=>"/", :"systemd-resolve"=>"/", :"systemd-timesync"=>"/", :"systemd-c...

# File:		user.rb | Line: 296
# Definition:	def homes_by_uid(id = get_uid)
LinuxStat::User.homes_by_uid(id)
=> ["/home/sourav"]

# File:		user.rb | Line: 25
# Definition:	def ids
LinuxStat::User.ids()
=> {:root=>{:uid=>0, :gid=>0}, :bin=>{:uid=>1, :gid=>1}, :daemon=>{:uid=>2, :gid=>2}, :mail=>{:uid=>8, :gid=>12}, :ftp=>{:uid=>14, :gid=>11}, :http=>{:uid=>33, :gid=>33}, :nobody=>{:uid=>65534, :gid=>65534}, :dbus=>{:uid=>81, :gid=>81}, :"systemd-journal...

# File:		user.rb | Line: 13
# Definition:	def list
LinuxStat::User.list()
=> ["root", "bin", "daemon", "mail", "ftp", "http", "nobody", "dbus", "systemd-journal-remote", "systemd-network", "systemd-resolve", "systemd-timesync", "systemd-coredump", "uuidd", "avahi", "colord", "git", "lxdm", "polkitd", "rtkit", "usbmux", "sourav...

# File:		user.rb | Line: 247
# Definition:	def uid_by_username(username = get_user)
LinuxStat::User.uid_by_username(username)
=> 1000

# File:		user.rb | Line: 42
# Definition:	def uids
LinuxStat::User.uids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>8, :ftp=>14, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :c...

# File:		user.rb | Line: 190
# Definition:	def username_by_gid(gid = get_gid)
LinuxStat::User.username_by_gid(gid)
=> "sourav"

# File:		user.rb | Line: 172
# Definition:	def usernames_by_uid(uid = get_uid)
LinuxStat::User.usernames_by_uid(uid)
=> ["sourav"]

```