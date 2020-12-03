require 'mkmf'

unless (have_header('sys/unistd.h') && have_header('ruby.h'))
	abort('Missing header')
end

create_makefile 'linux_stat/sysconf'
