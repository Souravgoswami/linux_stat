require 'mkmf'

unless have_const('linux') || RbConfig::CONFIG['arch'].to_s[/linux/]
	abort('Platform is not linux')
end

abort('Missing header') unless have_header('ftw.h')
create_makefile 'linux_stat/nftw'
