#include <unistd.h>
#include "ruby.h"

VALUE ticks ;

void set_ticks() {
	ticks = INT2FIX(sysconf(_SC_CLK_TCK)) ;
}

static VALUE getTick(VALUE obj) {
	return ticks ;
}

void Init_sysconf() {
	set_ticks() ;

	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE _sysconf = rb_define_module_under(_linux_stat, "Sysconf") ;
	rb_define_module_function(_sysconf, "sc_clk_tck", getTick, 0) ;
}
