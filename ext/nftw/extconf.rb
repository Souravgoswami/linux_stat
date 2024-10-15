require 'mkmf'

unless have_const('linux') || RbConfig::CONFIG['arch'].to_s[/linux/]
	abort('Platform is not linux')
end

abort('Missing header') unless have_header('ftw.h')

$CFLAGS << ' -O3 -march=native -mtune=native'

create_makefile 'linux_stat/nftw'
