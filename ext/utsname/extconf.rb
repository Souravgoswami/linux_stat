require 'mkmf'

unless (have_header('sys/utsname.h') && have_header('ruby.h'))
	abort('Missing header')
end

create_makefile 'linux_stat/utsname'
