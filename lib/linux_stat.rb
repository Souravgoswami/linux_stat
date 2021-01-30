# ----------------------------------------------------------------------------------------------------- #
# Don't edit this file unless you know what you are doing.                                               #
#                                                                                                                                  #
#  A file can have reverse dependency.                                                                         #
# For example, linux_stat/utsname is required before                                                    #
# linux_stat/os, which means utsname can be used by LinuxStat::OS and the files below.  #
#                                                                                                                                  #
# Once wrongly edited, you need to go through each method to know what                     #
# file is required by the module functions. Which can be very time consuming.                 #
#                                                                                                                                   #
# If you are writng an independent module, just add them under "Independent" section   #
# If you are writing a dependent module, just append that to the end of the file.             #
# If you are writing something that is miscellaneous, just add it to miscellaneous section #
# ------------------------------------------------------------------------------------------------------ #

# Miscellaneous Modules
# Independed and LinuxStat's miscellaneous modules
require 'linux_stat/prettify_bytes'
require "linux_stat/version"

# Independed Modules
# Modules that doesn't have any dependency on its own
# But might be required by other module functions in "Dependent Modules" section
require "linux_stat/battery"
require "linux_stat/bios"
require "linux_stat/net"
require "linux_stat/pci"
require "linux_stat/procfs"
require "linux_stat/process"
require "linux_stat/thermal"
require "linux_stat/usb"

# Dependent Modules
# Modules that can have reverse dependency

# LinuxStat::CPU.sysinfo dependent modules
require "linux_stat/sysinfo"
require "linux_stat/swap"
require "linux_stat/memory"

# LinuxStat::CPU.nproc dependent modules
require "linux_stat/nproc"
require "linux_stat/cpu"

# LinuxStat::Uname dependent modules
require 'linux_stat/utsname'
require "linux_stat/os"

# LinuxStat::FS dependent modules
require "linux_stat/fs_stat"
require "linux_stat/filesystem"
require "linux_stat/mounts"

# LinuxStat::Sysconf dependent modules
require "linux_stat/sysconf"
require "linux_stat/kernel"
require 'linux_stat/user'
require "linux_stat/process_info"

# A short alias to LinuxStat
LS = LinuxStat
