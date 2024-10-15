require 'mkmf'

unless have_const('linux') || RbConfig::CONFIG['arch'].to_s[/linux/]
	abort('Platform is not linux')
end

unless have_header('sys/statvfs.h') && have_header('sys/ioctl.h') &&
	have_header('fcntl.h') && have_header('linux/fs.h') && have_header('unistd.h')
	abort('Missing header')
end

$CFLAGS << ' -O3 -march=native -mtune=native'

create_makefile 'linux_stat/fs_stat'
