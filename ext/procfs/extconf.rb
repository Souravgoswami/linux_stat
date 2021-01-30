require 'mkmf'

unless have_const('linux') || RbConfig::CONFIG['arch'].to_s[/linux/]
	abort('Platform is not linux')
end

unless have_header('ruby.h')
	abort('Missing header')
end

create_makefile 'linux_stat/procfs'
