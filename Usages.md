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
=> 96.27998042094958

# File:		battery.rb | Line: 132
# Definition:	def charge_full_design_wh
LinuxStat::Battery.charge_full_design_wh()
=> 43.32

# File:		battery.rb | Line: 151
# Definition:	def charge_full_wh
LinuxStat::Battery.charge_full_wh()
=> 23.29

# File:		battery.rb | Line: 80
# Definition:	def charging?
LinuxStat::Battery.charging?()
=> false

# File:		battery.rb | Line: 201
# Definition:	def devices_stat
LinuxStat::Battery.devices_stat()
=> {:AC=>{:type=>"Mains", :online=>0}, :BAT0=>{:model=>"DELL 35RH35C", :manufacturer=>"SMP", :type=>"Battery", :status=>"Discharging", :capacity=>96, :voltage_min_design=>11.4, :charge_full_design=>3.8, :charge_full_design_wh=>43.32, :voltage_now=>12.102...

# File:		battery.rb | Line: 89
# Definition:	def discharging?
LinuxStat::Battery.discharging?()
=> true

# File:		battery.rb | Line: 98
# Definition:	def full?
LinuxStat::Battery.full?()
=> false

# File:		battery.rb | Line: 49
# Definition:	def manufacturer
LinuxStat::Battery.manufacturer()
=> "SMP"

# File:		battery.rb | Line: 38
# Definition:	def model
LinuxStat::Battery.model()
=> "DELL 35RH35C"

# File:		battery.rb | Line: 10
# Definition:	def present?
LinuxStat::Battery.present?()
=> true

# File:		battery.rb | Line: 18
# Definition:	def stat
LinuxStat::Battery.stat()
=> {:model=>"DELL 35RH35C", :manufacturer=>"SMP", :technology=>"Li-ion", :status=>"Discharging", :charge=>96.27998042094958, :charging=>false, :discharging=>true, :full=>false}

# File:		battery.rb | Line: 70
# Definition:	def status
LinuxStat::Battery.status()
=> "Discharging"

# File:		battery.rb | Line: 59
# Definition:	def technology
LinuxStat::Battery.technology()
=> "Li-ion"

# File:		battery.rb | Line: 170
# Definition:	def voltage_now
LinuxStat::Battery.voltage_now()
=> 12.102

```

### LinuxStat::CPU
```
# File:		cpu.rb | Line: 294
# Definition:	def available_governors
LinuxStat::CPU.available_governors()
=> {"cpu0"=>["performance", "powersave"], "cpu1"=>["performance", "powersave"], "cpu2"=>["performance", "powersave"], "cpu3"=>["performance", "powersave"]}

# File:		cpu.rb | Line: 89
# Definition:	def count
LinuxStat::CPU.count()
=> 4

# File:		cpu.rb | Line: 106
# Definition:	def count_online
LinuxStat::CPU.count_online()
=> 4

# File:		cpu.rb | Line: 200
# Definition:	def cur_freq
LinuxStat::CPU.cur_freq()
=> {"cpu0"=>2000707, "cpu1"=>2000113, "cpu2"=>2000401, "cpu3"=>2000085}

# File:		cpu.rb | Line: 272
# Definition:	def governor
LinuxStat::CPU.governor()
=> {"cpu0"=>"performance", "cpu1"=>"performance", "cpu2"=>"performance", "cpu3"=>"performance"}

# File:		cpu.rb | Line: 354
# Definition:	def hyperthreaded_core_list
LinuxStat::CPU.hyperthreaded_core_list()
=> [3, 2]

# File:		cpu.rb | Line: 354
# Definition:	def hyperthreaded_core_list
LinuxStat::CPU.hyperthreaded_cores()
=> [3, 2]

# File:		cpu.rb | Line: 248
# Definition:	def max_freq
LinuxStat::CPU.max_freq()
=> {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}

# File:		cpu.rb | Line: 226
# Definition:	def min_freq
LinuxStat::CPU.min_freq()
=> {"cpu0"=>2000000, "cpu1"=>2000000, "cpu2"=>2000000, "cpu3"=>2000000}

# File:		cpu.rb | Line: 187
# Definition:	def model
LinuxStat::CPU.model()
=> "Intel(R) Core(TM) i3-6006U CPU @ 2.00GHz"

# File:		cpu.rb | Line: 166
# Definition:	def offline
LinuxStat::CPU.offline()
=> []

# File:		cpu.rb | Line: 135
# Definition:	def online
LinuxStat::CPU.online()
=> [0, 1, 2, 3]

# File:		cpu.rb | Line: 314
# Definition:	def physical_core_list
LinuxStat::CPU.physical_core_list()
=> [1, 0]

# File:		cpu.rb | Line: 314
# Definition:	def physical_core_list
LinuxStat::CPU.physical_cores()
=> [1, 0]

# File:		cpu.rb | Line: 25
# Definition:	def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.stat(sleep)
=> {0=>0.0, 1=>0.0, 2=>0.0, 3=>0.0, 4=>0.0}

# File:		cpu.rb | Line: 213
# Definition:	def times
LinuxStat::CPU.times()
=> [{:cpu=>"cpu", :user=>37.310001373291016, :nice=>0.11999999731779099, :system=>9.460000038146973, :idle=>1097.3499755859375, :iowait=>5.019999980926514, :irq=>0.0, :softirq=>0.41999998688697815, :steal=>0.0, :guest=>0.0, :guest_nice=>0.0}, {:cpu=>"cpu...

# File:		cpu.rb | Line: 66
# Definition:	def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.total_usage(sleep)
=> 0.0

# File:		cpu.rb | Line: 66
# Definition:	def total_usage(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usage(sleep)
=> 0.0

# File:		cpu.rb | Line: 25
# Definition:	def stat(sleep = ticks_to_ms_t5)
LinuxStat::CPU.usages(sleep)
=> {0=>4.76, 1=>0.0, 2=>16.67, 3=>0.0, 4=>0.0}

```

### LinuxStat::FS
```
LinuxStat::FS.sectors(arg = "/")
=> nil

LinuxStat::FS.stat(arg = "/")
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29291798, :block_free=>13058075, :block_avail_unpriv=>13058075, :inodes=>58612160, :free_inodes=>57763201, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

LinuxStat::FS.total_io(arg = "/")
=> []

```

### LinuxStat::Filesystem
```
# File:		filesystem.rb | Line: 94
# Definition:	def available(fs = ?..freeze)
LinuxStat::Filesystem.available(fs)
=> 53485875200

# File:		filesystem.rb | Line: 60
# Definition:	def free(fs = ?..freeze)
LinuxStat::Filesystem.free(fs)
=> 53485875200

# File:		filesystem.rb | Line: 118
# Definition:	def io_total(path = LinuxStat::Mounts.root)
LinuxStat::Filesystem.io_total(path)
=> {:read=>411149824, :write=>26372608}

# File:		filesystem.rb | Line: 133
# Definition:	def io_usage(path = LinuxStat::Mounts.root, interval = 0.1)
LinuxStat::Filesystem.io_usage(path, interval)
=> {:read=>0.0, :write=>0.0}

# File:		filesystem.rb | Line: 114
# Definition:	def sector_size(path = LinuxStat::Mounts.root)
LinuxStat::Filesystem.sector_size(path)
=> 512

# File:		filesystem.rb | Line: 114
# Definition:	def sector_size(path = LinuxStat::Mounts.root)
LinuxStat::Filesystem.sectors(path)
=> 512

# File:		filesystem.rb | Line: 21
# Definition:	def stat(fs = ?..freeze)
LinuxStat::Filesystem.stat(fs)
=> {:total=>119979204608, :free=>53485875200, :used=>66493329408}

# File:		filesystem.rb | Line: 110
# Definition:	def stat_raw(fs = ?..freeze)
LinuxStat::Filesystem.stat_raw(fs)
=> {:block_size=>4096, :fragment_size=>4096, :blocks=>29291798, :block_free=>13058075, :block_avail_unpriv=>13058075, :inodes=>58612160, :free_inodes=>57763201, :filesystem_id=>2050, :mount_flags=>1024, :max_filename_length=>255}

# File:		filesystem.rb | Line: 41
# Definition:	def total(fs = ?..freeze)
LinuxStat::Filesystem.total(fs)
=> 119979204608

# File:		filesystem.rb | Line: 75
# Definition:	def used(fs = ?..freeze)
LinuxStat::Filesystem.used(fs)
=> 66493329408

```

### LinuxStat::Kernel
```
# File:		kernel.rb | Line: 88
# Definition:	def build_date
LinuxStat::Kernel.build_date()
=> 2021-10-13 20:10:58 +0000

# File:		kernel.rb | Line: 142
# Definition:	def build_date_string
LinuxStat::Kernel.build_date_string()
=> "13 Oct 2021 20:10:58 +0000"

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
=> [:clang, "12.0.1"]

# File:		kernel.rb | Line: 57
# Definition:	def compiler_version
LinuxStat::Kernel.compiler_version()
=> "12.0.1"

# File:		kernel.rb | Line: 12
# Definition:	def version
LinuxStat::Kernel.release()
=> "5.14.12-xanmod1-cacule-1-edge"

# File:		kernel.rb | Line: 171
# Definition:	def string
LinuxStat::Kernel.string()
=> "Linux version 5.14.12-xanmod1-cacule-1-edge (souravgoswami@archlinux) (clang version 12.0.1, LLD 12.0.1) #1 SMP Wed, 13 Oct 2021 20:10:58 +0000"

# File:		kernel.rb | Line: 181
# Definition:	def ticks
LinuxStat::Kernel.ticks()
=> 100

# File:		kernel.rb | Line: 12
# Definition:	def version
LinuxStat::Kernel.version()
=> "5.14.12-xanmod1-cacule-1-edge"

```

### LinuxStat::Memory
```
# File:		memory.rb | Line: 62
# Definition:	def available
LinuxStat::Memory.available()
=> 7074200

# File:		memory.rb | Line: 52
# Definition:	def free
LinuxStat::Memory.free()
=> 6916460

# File:		memory.rb | Line: 93
# Definition:	def percent_available
LinuxStat::Memory.percent_available()
=> 88.92

# File:		memory.rb | Line: 82
# Definition:	def percent_used
LinuxStat::Memory.percent_used()
=> 11.08

# File:		memory.rb | Line: 13
# Definition:	def stat
LinuxStat::Memory.stat()
=> {:total=>7955492, :used=>881292, :available=>7074200, :percent_used=>11.08, :percent_available=>88.92}

# File:		memory.rb | Line: 42
# Definition:	def total
LinuxStat::Memory.total()
=> 7955492

# File:		memory.rb | Line: 72
# Definition:	def used
LinuxStat::Memory.used()
=> 881292

```

### LinuxStat::Misc
```
```

### LinuxStat::Mounts
```
# File:		mounts.rb | Line: 181
# Definition:	def device_stat(dev = root)
LinuxStat::Mounts.device_stat(dev)
=> {:mountpoint=>"/", :total=>119979204608, :free=>53485875200, :available=>53485875200, :used=>66493329408, :percent_used=>55.42, :percent_free=>44.58, :percent_available=>44.58}

# File:		mounts.rb | Line: 139
# Definition:	def devices_stat
LinuxStat::Mounts.devices_stat()
=> {"proc"=>{:mountpoint=>"/proc", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_free=>NaN, :percent_available=>NaN}, "sys"=>{:mountpoint=>"/sys", :total=>0, :free=>0, :available=>0, :used=>0, :percent_used=>NaN, :percent_fre...

# File:		mounts.rb | Line: 13
# Definition:	def list
LinuxStat::Mounts.list()
=> ["proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0", "sys /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0", "dev /dev devtmpfs rw,nosuid,relatime,size=3967752k,nr_inodes=991938,mode=755,inode64 0 0", "run /run tmpfs rw,nosuid,nodev,relatime,mode=755...

# File:		mounts.rb | Line: 22
# Definition:	def list_devices
LinuxStat::Mounts.list_devices()
=> ["proc", "sys", "dev", "run", "/dev/sda2", "securityfs", "tmpfs", "devpts", "cgroup2", "pstore", "none", "systemd-1", "hugetlbfs", "mqueue", "debugfs", "configfs", "fusectl", "tmpfs", "tmpfs", "tmpfs", "gvfsd-fuse", "binfmt_misc"]

# File:		mounts.rb | Line: 111
# Definition:	def list_devices_mount_point
LinuxStat::Mounts.list_devices_mount_point()
=> {"proc"=>"/proc", "sys"=>"/sys", "dev"=>"/dev", "run"=>"/run", "/dev/sda2"=>"/", "securityfs"=>"/sys/kernel/security", "tmpfs"=>"/run/user/1000", "devpts"=>"/dev/pts", "cgroup2"=>"/sys/fs/cgroup", "pstore"=>"/sys/fs/pstore", "none"=>"/sys/fs/bpf", "sy...

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
=> {"/dev/shm"=>"tmpfs /dev/shm tmpfs rw,nosuid,nodev,inode64 0 0", "/tmp"=>"tmpfs /tmp tmpfs rw,nosuid,nodev,noatime,size=4194304k,inode64 0 0", "/ramdisk"=>"tmpfs /ramdisk tmpfs rw,nosuid,nodev,noatime,size=4194304k,inode64 0 0", "/run/user/1000"=>"tmp...

```

### LinuxStat::Net
```
# File:		net.rb | Line: 86
# Definition:	def usage(interval = 0.1)
LinuxStat::Net.current_usage(interval)
=> {:received=>6180.0, :transmitted=>5700.0}

# File:		net.rb | Line: 12
# Definition:	def ipv4_private
LinuxStat::Net.ipv4_private()
=> "192.168.0.3"

# File:		net.rb | Line: 27
# Definition:	def total_bytes
LinuxStat::Net.total_bytes()
=> {:received=>797220, :transmitted=>385063}

# File:		net.rb | Line: 45
# Definition:	def total_bytes_received
LinuxStat::Net.total_bytes_received()
=> 797220

# File:		net.rb | Line: 58
# Definition:	def total_bytes_transmitted
LinuxStat::Net.total_bytes_transmitted()
=> 385321

# File:		net.rb | Line: 86
# Definition:	def usage(interval = 0.1)
LinuxStat::Net.usage(interval)
=> {:received=>1320.0, :transmitted=>4060.0}

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
=> "archlinux-laptop"

# File:		os.rb | Line: 208
# Definition:	def loadavg
LinuxStat::OS.loadavg()
=> {1=>0.04931640625, 5=>0.14990234375, 15=>0.07958984375}

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
=> "archlinux-laptop"

# File:		os.rb | Line: 23
# Definition:	def os_release
LinuxStat::OS.os_release()
=> {:NAME=>"Arch Linux", :PRETTY_NAME=>"Arch Linux", :ID=>"arch", :BUILD_ID=>"rolling", :ANSI_COLOR=>"38;2;23;147;209", :HOME_URL=>"https://archlinux.org/", :DOCUMENTATION_URL=>"https://wiki.archlinux.org/", :SUPPORT_URL=>"https://bbs.archlinux.org/", :B...

# File:		os.rb | Line: 150
# Definition:	def uptime
LinuxStat::OS.uptime()
=> {:hour=>0, :minute=>4, :second=>49, :jiffy=>38}

# File:		os.rb | Line: 180
# Definition:	def uptime_f
LinuxStat::OS.uptime_f()
=> 289.39

# File:		os.rb | Line: 191
# Definition:	def uptime_i
LinuxStat::OS.uptime_i()
=> 290

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
=> 17

# File:		pci.rb | Line: 216
# Definition:	def count
LinuxStat::PCI.count_devices()
=> 17

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
# File:		prettify_bytes.rb | Line: 92
# Definition:	def convert_binary(n, precision: 2)
LinuxStat::PrettifyBytes.convert_binary(n = 742154629047736, precision:)
=> "674.99 tebibytes"

# File:		prettify_bytes.rb | Line: 48
# Definition:	def convert_decimal(n, precision: 2)
LinuxStat::PrettifyBytes.convert_decimal(n = 602218351312741, precision:)
=> "602.22 terabytes"

# File:		prettify_bytes.rb | Line: 182
# Definition:	def convert_short_binary(n, precision: 2)
LinuxStat::PrettifyBytes.convert_short_binary(n = 931174422349394, precision:)
=> "846.90 TiB"

# File:		prettify_bytes.rb | Line: 136
# Definition:	def convert_short_decimal(n, precision: 2)
LinuxStat::PrettifyBytes.convert_short_decimal(n = 163958894705443, precision:)
=> "163.96 TB"

```

### LinuxStat::ProcFS
```
LinuxStat::ProcFS.cpu_times()
=> [{:cpu=>"cpu", :user=>37.529998779296875, :nice=>0.11999999731779099, :system=>9.489999771118164, :idle=>1099.8800048828125, :iowait=>5.019999980926514, :irq=>0.0, :softirq=>0.4300000071525574, :steal=>0.0, :guest=>0.0, :guest_nice=>0.0}, {:cpu=>"cpu0...

LinuxStat::ProcFS.last_pid()
=> 1885

LinuxStat::ProcFS.list_process()
=> [116, 117, 118, 119, 120, 121, 122, 123, 124, 133, 136, 137, 138, 139, 144, 156, 164, 170, 171, 172, 173, 174, 175, 182, 183, 184, 185, 186, 187, 188, 217, 227, 228, 230, 271, 275, 277, 281, 290, 299, 301, 302, 304, 323, 326, 337, 350, 364, 365, 367,...

LinuxStat::ProcFS.uptime_f()
=> 289.61

```

### LinuxStat::Process
```
# File:		process.rb | Line: 47
# Definition:	def cmdlines
LinuxStat::Process.cmdlines()
=> {116=>"", 117=>"", 118=>"", 119=>"", 120=>"", 121=>"", 122=>"", 123=>"", 124=>"", 133=>"", 136=>"", 137=>"", 138=>"", 139=>"", 144=>"", 156=>"", 164=>"", 170=>"", 171=>"", 172=>"", 173=>"", 174=>"", 175=>"", 182=>"", 183=>"", 184=>"", 185=>"", 186=>""...

# File:		process.rb | Line: 19
# Definition:	def count
LinuxStat::Process.count()
=> 175

# File:		process.rb | Line: 110
# Definition:	def idle
LinuxStat::Process.idle()
=> [116, 117, 118, 119, 120, 121, 122, 123, 124, 133, 136, 137, 138, 139, 144, 156, 164, 171, 173, 174, 175, 182, 183, 184, 185, 186, 187, 227, 281, 290, 299, 301, 302, 304, 350, 364, 365, 367, 376, 386, 387, 413, 3, 4, 5, 6, 7, 8, 11, 19, 20, 25, 26, 31...

# File:		process.rb | Line: 150
# Definition:	def last_pid
LinuxStat::Process.last_pid()
=> 1885

# File:		process.rb | Line: 11
# Definition:	def list
LinuxStat::Process.list()
=> [116, 117, 118, 119, 120, 121, 122, 123, 124, 133, 136, 137, 138, 139, 144, 156, 164, 170, 171, 172, 173, 174, 175, 182, 183, 184, 185, 186, 187, 188, 217, 227, 228, 230, 271, 275, 277, 281, 290, 299, 301, 302, 304, 323, 326, 337, 350, 364, 365, 367,...

# File:		process.rb | Line: 26
# Definition:	def names
LinuxStat::Process.names()
=> {116=>"acpi_thermal_pm", 117=>"kworker/u8:2-phy0", 118=>"kworker/u8:3-events_unbound", 119=>"kworker/3:2-mm_percpu_wq", 120=>"vfio-irqfd-clea", 121=>"kworker/1:2-events", 122=>"kworker/1:3-events", 123=>"mld", 124=>"ipv6_addrconf", 133=>"kstrp", 136=>...

# File:		process.rb | Line: 128
# Definition:	def running
LinuxStat::Process.running()
=> [1883]

# File:		process.rb | Line: 101
# Definition:	def sleeping
LinuxStat::Process.sleeping()
=> [170, 172, 188, 217, 228, 230, 271, 275, 277, 323, 326, 337, 372, 373, 374, 382, 389, 397, 427, 430, 451, 454, 455, 461, 468, 480, 485, 492, 498, 500, 506, 507, 521, 528, 530, 538, 540, 543, 546, 550, 555, 558, 559, 566, 568, 569, 600, 601, 603, 605,...

# File:		process.rb | Line: 137
# Definition:	def stopped
LinuxStat::Process.stopped()
=> []

# File:		process.rb | Line: 68
# Definition:	def types
LinuxStat::Process.types()
=> {116=>:idle, 117=>:idle, 118=>:idle, 119=>:idle, 120=>:idle, 121=>:idle, 122=>:idle, 123=>:idle, 124=>:idle, 133=>:idle, 136=>:idle, 137=>:idle, 138=>:idle, 139=>:idle, 144=>:idle, 156=>:idle, 164=>:idle, 170=>:sleeping, 171=>:idle, 172=>:sleeping, 17...

# File:		process.rb | Line: 119
# Definition:	def zombie
LinuxStat::Process.zombie()
=> []

```

### LinuxStat::ProcessInfo
```
# File:		process_info.rb | Line: 61
# Definition:	def cmdline(pid = $$)
LinuxStat::ProcessInfo.cmdline(pid)
=> "/usr/bin/ruby /home/sourav/.gem/ruby/3.0.0/bin/linuxstat.rb -md"

# File:		process_info.rb | Line: 87
# Definition:	def command_name(pid = $$)
LinuxStat::ProcessInfo.command_name(pid)
=> "ruby"

# File:		process_info.rb | Line: 610
# Definition:	def nproc(pid = $$)
LinuxStat::ProcessInfo.count_cpu(pid)
=> 4

# File:		process_info.rb | Line: 280
# Definition:	def cpu_stat(pid: $$, sleep: ticks_to_ms_t5)
LinuxStat::ProcessInfo.cpu_stat(pid:, sleep:)
=> {:cpu_usage=>0.0, :threads=>0, :last_executed_cpu=>0}

# File:		process_info.rb | Line: 621
# Definition:	def cpu_time(pid = $$)
LinuxStat::ProcessInfo.cpu_time(pid)
=> 0.4300000071525574

# File:		process_info.rb | Line: 636
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
=> {:real=>0, :effective=>0, :saved_set=>0, :filesystem_uid=>0}

# File:		process_info.rb | Line: 416
# Definition:	def last_executed_cpu(pid = $$)
LinuxStat::ProcessInfo.last_executed_cpu(pid)
=> 2

# File:		process_info.rb | Line: 151
# Definition:	def mem_stat(pid = $$)
LinuxStat::ProcessInfo.mem_stat(pid)
=> {:memory=>27430912, :virtual_memory=>100012032, :resident_memory=>33738752, :shared_memory=>6307840}

# File:		process_info.rb | Line: 171
# Definition:	def memory(pid = $$)
LinuxStat::ProcessInfo.memory(pid)
=> 27430.912

# File:		process_info.rb | Line: 580
# Definition:	def nice(pid = $$)
LinuxStat::ProcessInfo.nice(pid)
=> 0

# File:		process_info.rb | Line: 610
# Definition:	def nproc(pid = $$)
LinuxStat::ProcessInfo.nproc(pid)
=> 4

# File:		process_info.rb | Line: 471
# Definition:	def owner(pid = $$)
LinuxStat::ProcessInfo.owner(pid)
=> "root"

# File:		process_info.rb | Line: 112
# Definition:	def process_name(pid = $$)
LinuxStat::ProcessInfo.process_name(pid)
=> "linuxstat.rb"

# File:		process_info.rb | Line: 213
# Definition:	def resident_memory(pid = $$)
LinuxStat::ProcessInfo.resident_memory(pid)
=> 33738.752

# File:		process_info.rb | Line: 542
# Definition:	def running_time(pid = $$)
LinuxStat::ProcessInfo.running_time(pid)
=> 3.11

# File:		process_info.rb | Line: 234
# Definition:	def shared_memory(pid = $$)
LinuxStat::ProcessInfo.shared_memory(pid)
=> 6307.84

# File:		process_info.rb | Line: 521
# Definition:	def start_time(pid = $$)
LinuxStat::ProcessInfo.start_time(pid)
=> 2021-10-23 22:23:47 +0530

# File:		process_info.rb | Line: 493
# Definition:	def start_time_epoch(pid = $$)
LinuxStat::ProcessInfo.start_time_epoch(pid)
=> 1635008027

# File:		process_info.rb | Line: 567
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
=> {:read_bytes=>0, :write_bytes=>0}

# File:		process_info.rb | Line: 426
# Definition:	def uid(pid = $$)
LinuxStat::ProcessInfo.uid(pid)
=> {:real=>0, :effective=>0, :saved_set=>0, :filesystem_uid=>0}

# File:		process_info.rb | Line: 192
# Definition:	def virtual_memory(pid = $$)
LinuxStat::ProcessInfo.virtual_memory(pid)
=> 100012.032

```

### LinuxStat::Swap
```
# File:		swap.rb | Line: 25
# Definition:	def any?
LinuxStat::Swap.any?()
=> true

# File:		swap.rb | Line: 86
# Definition:	def available
LinuxStat::Swap.available()
=> 6291452

# File:		swap.rb | Line: 75
# Definition:	def free
LinuxStat::Swap.free()
=> 6291452

# File:		swap.rb | Line: 10
# Definition:	def list
LinuxStat::Swap.list()
=> {"/dev/zram0"=>[:partition, 6291452, 0, -2]}

# File:		swap.rb | Line: 129
# Definition:	def percent_available
LinuxStat::Swap.percent_available()
=> 100.0

# File:		swap.rb | Line: 109
# Definition:	def percent_used
LinuxStat::Swap.percent_used()
=> 0.0

# File:		swap.rb | Line: 36
# Definition:	def stat
LinuxStat::Swap.stat()
=> {:total=>6291452, :used=>0, :available=>6291452, :percent_used=>0.0, :percent_available=>100.0}

# File:		swap.rb | Line: 64
# Definition:	def total
LinuxStat::Swap.total()
=> 6291452

# File:		swap.rb | Line: 100
# Definition:	def used
LinuxStat::Swap.used()
=> 0

```

### LinuxStat::Sysconf
```
LinuxStat::Sysconf.child_max()
=> 30997

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
=> "archlinux-laptop"

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
=> 1925120

LinuxStat::Sysinfo.freehigh()
=> 0

LinuxStat::Sysinfo.freeram()
=> 7066972160

LinuxStat::Sysinfo.freeswap()
=> 6442446848

LinuxStat::Sysinfo.loads()
=> [0.04931640625, 0.14990234375, 0.07958984375]

LinuxStat::Sysinfo.sharedram()
=> 86675456

LinuxStat::Sysinfo.stat()
=> {:totalram=>8146423808, :freeram=>7066972160, :sharedram=>86675456, :bufferram=>1925120, :totalswap=>6442446848, :freeswap=>6442446848, :totalhigh=>0, :freehigh=>0, :uptime=>290, :loads=>[0.04931640625, 0.14990234375, 0.07958984375]}

LinuxStat::Sysinfo.totalhigh()
=> 0

LinuxStat::Sysinfo.totalram()
=> 8146423808

LinuxStat::Sysinfo.totalswap()
=> 6442446848

LinuxStat::Sysinfo.uptime()
=> 290

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
=> [{:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"Processor Fan", :rpm=>0}]

# File:		thermal.rb | Line: 23
# Definition:	def temperatures
LinuxStat::Thermal.temperatures()
=> [{:path=>"/sys/class/hwmon/hwmon1", :name=>"acpitz", :temperature=>25.0, :temp_crit=>107.0}, {:path=>"/sys/class/hwmon/hwmon3", :name=>"pch_skylake", :temperature=>35.0}, {:path=>"/sys/class/hwmon/hwmon4", :name=>"dell_smm", :label=>"CPU", :temperatur...

```

### LinuxStat::USB
```
# File:		usb.rb | Line: 139
# Definition:	def count
LinuxStat::USB.count()
=> 5

# File:		usb.rb | Line: 139
# Definition:	def count
LinuxStat::USB.count_devices()
=> 5

# File:		usb.rb | Line: 49
# Definition:	def devices_stat(hwdata: true)
LinuxStat::USB.devices_stat(hwdata:)
=> [{:path=>"/sys/bus/usb/devices/1-5/", :id=>"0c45:6a06", :vendor_id=>"0c45", :product_id=>"6a06", :bus_num=>1, :dev_num=>2, :hwdata=>{:vendor=>"Microdia", :product=>nil}, :product=>"Integrated_Webcam_HD", :manufacturer=>"CNFFH37N1511820000HE", :removab...

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
=> "archlinux-laptop"

LinuxStat::Uname.release()
=> "5.14.12-xanmod1-cacule-1-edge"

LinuxStat::Uname.sysname()
=> "Linux"

LinuxStat::Uname.version()
=> "#1 SMP Wed, 13 Oct 2021 20:10:58 +0000"

```

### LinuxStat::User
```
# File:		user.rb | Line: 107
# Definition:	def get_user
LinuxStat::User.get_current_user()
=> "root"

# File:		user.rb | Line: 146
# Definition:	def get_euid
LinuxStat::User.get_euid()
=> 0

# File:		user.rb | Line: 138
# Definition:	def get_gid
LinuxStat::User.get_gid()
=> 0

# File:		user.rb | Line: 161
# Definition:	def get_login
LinuxStat::User.get_login()
=> "sourav"

# File:		user.rb | Line: 130
# Definition:	def get_uid
LinuxStat::User.get_uid()
=> 0

# File:		user.rb | Line: 107
# Definition:	def get_user
LinuxStat::User.get_user()
=> "root"

# File:		user.rb | Line: 224
# Definition:	def gid_by_username(username = get_user)
LinuxStat::User.gid_by_username(username)
=> 0

# File:		user.rb | Line: 62
# Definition:	def gids
LinuxStat::User.gids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>12, :ftp=>11, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :...

# File:		user.rb | Line: 323
# Definition:	def home_by_gid(id = get_gid)
LinuxStat::User.home_by_gid(id)
=> "/root"

# File:		user.rb | Line: 275
# Definition:	def home_by_username(user = get_user)
LinuxStat::User.home_by_username(user)
=> "/root"

# File:		user.rb | Line: 80
# Definition:	def home_directories
LinuxStat::User.home_directories()
=> {:root=>"/root", :bin=>"/", :daemon=>"/", :mail=>"/var/spool/mail", :ftp=>"/srv/ftp", :http=>"/srv/http", :nobody=>"/", :dbus=>"/", :"systemd-journal-remote"=>"/", :"systemd-network"=>"/", :"systemd-resolve"=>"/", :"systemd-timesync"=>"/", :"systemd-c...

# File:		user.rb | Line: 302
# Definition:	def homes_by_uid(id = get_uid)
LinuxStat::User.homes_by_uid(id)
=> ["/root"]

# File:		user.rb | Line: 25
# Definition:	def ids
LinuxStat::User.ids()
=> {:root=>{:uid=>0, :gid=>0}, :bin=>{:uid=>1, :gid=>1}, :daemon=>{:uid=>2, :gid=>2}, :mail=>{:uid=>8, :gid=>12}, :ftp=>{:uid=>14, :gid=>11}, :http=>{:uid=>33, :gid=>33}, :nobody=>{:uid=>65534, :gid=>65534}, :dbus=>{:uid=>81, :gid=>81}, :"systemd-journal...

# File:		user.rb | Line: 13
# Definition:	def list
LinuxStat::User.list()
=> ["root", "bin", "daemon", "mail", "ftp", "http", "nobody", "dbus", "systemd-journal-remote", "systemd-network", "systemd-resolve", "systemd-timesync", "systemd-coredump", "uuidd", "avahi", "colord", "polkitd", "rtkit", "usbmux", "lxdm", "sourav", "cup...

# File:		user.rb | Line: 253
# Definition:	def uid_by_username(username = get_user)
LinuxStat::User.uid_by_username(username)
=> 0

# File:		user.rb | Line: 44
# Definition:	def uids
LinuxStat::User.uids()
=> {:root=>0, :bin=>1, :daemon=>2, :mail=>8, :ftp=>14, :http=>33, :nobody=>65534, :dbus=>81, :"systemd-journal-remote"=>982, :"systemd-network"=>981, :"systemd-resolve"=>980, :"systemd-timesync"=>979, :"systemd-coredump"=>978, :uuidd=>68, :avahi=>977, :c...

# File:		user.rb | Line: 196
# Definition:	def username_by_gid(gid = get_gid)
LinuxStat::User.username_by_gid(gid)
=> "root"

# File:		user.rb | Line: 178
# Definition:	def usernames_by_uid(uid = get_uid)
LinuxStat::User.usernames_by_uid(uid)
=> ["root"]

```
