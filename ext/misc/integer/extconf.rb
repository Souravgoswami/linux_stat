require 'mkmf'

$CFLAGS << ' -O3 -march=native -mtune=native'

create_makefile 'linux_stat/misc/integer'
