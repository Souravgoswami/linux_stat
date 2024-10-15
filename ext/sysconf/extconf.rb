require 'mkmf'

unless have_const('linux') || RbConfig::CONFIG['arch'].to_s[/linux/]
	abort('Platform is not linux')
end

unless have_header('unistd.h') && have_header('ruby.h')
	abort('Missing header')
end

$CFLAGS << ' -O3 -march=native -mtune=native'

create_makefile 'linux_stat/sysconf'
