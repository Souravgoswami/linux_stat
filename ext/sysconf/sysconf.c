#include <unistd.h>
#include "ruby.h"

static VALUE getTick(VALUE obj) {
	return INT2FIX(sysconf(_SC_CLK_TCK)) ;
}

static VALUE getChildMax(VALUE obj) {
	return INT2FIX(sysconf(_SC_CHILD_MAX)) ;
}

static VALUE getHostnameMax(VALUE obj) {
	return INT2FIX(sysconf(_SC_HOST_NAME_MAX)) ;
}

static VALUE getLoginNameMax(VALUE obj) {
	return INT2FIX(sysconf(_SC_LOGIN_NAME_MAX)) ;
}

static VALUE getOpenMax(VALUE obj) {
	return INT2FIX(sysconf(_SC_OPEN_MAX)) ;
}

static VALUE getPageSizeMax(VALUE obj) {
	return INT2FIX(sysconf(_SC_PAGESIZE)) ;
}

static VALUE getStreamMax(VALUE obj) {
	return INT2FIX(sysconf(_SC_STREAM_MAX)) ;
}

static VALUE getTTYNameMax(VALUE obj) {
	return INT2FIX(sysconf(_SC_TTY_NAME_MAX)) ;
}

static VALUE getPosixVersion(VALUE obj) {
	return INT2FIX(sysconf(_SC_VERSION)) ;
}

void Init_sysconf() {
	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE _sysconf = rb_define_module_under(_linux_stat, "Sysconf") ;

	rb_define_module_function(_sysconf, "sc_clk_tck", getTick, 0) ;
	rb_define_module_function(_sysconf, "child_max", getChildMax, 0) ;
	rb_define_module_function(_sysconf, "hostname_max", getHostnameMax, 0) ;
	rb_define_module_function(_sysconf, "login_name_max", getLoginNameMax, 0) ;
	rb_define_module_function(_sysconf, "open_max", getOpenMax, 0) ;
	rb_define_module_function(_sysconf, "page_size_max", getPageSizeMax, 0) ;
	rb_define_module_function(_sysconf, "stream_max", getStreamMax, 0) ;
	rb_define_module_function(_sysconf, "tty_name_max", getTTYNameMax, 0) ;
	rb_define_module_function(_sysconf, "posix_version", getPosixVersion, 0) ;
}
