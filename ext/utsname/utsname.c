#include <sys/utsname.h>
#include "ruby.h"

#if defined(__GNUC__) && !defined(__clang__) && !defined(__INTEL_COMPILER)
	#pragma GCC optimize ("O3")
	#pragma GCC diagnostic warning "-Wall"
#elif defined(__clang__)
	#pragma clang optimize on
	#pragma clang diagnostic warning "-Wall"
#elif defined(__INTEL_COMPILER)
	#pragma intel optimization_level 3
#endif

static struct utsname buf ;

static char *sysname = "", *nodename = "" ;
static char *release = "", *version = "", *machine = "" ;

void init_buf() {
	char status = uname(&buf) ;

	if (status > -1) {
		sysname = buf.sysname ;
		nodename = buf.nodename ;
		release = buf.release ;
		version = buf.version ;
		machine = buf.machine ;
	}
}

static VALUE getSysname(VALUE obj) {
	return rb_str_new_cstr(sysname) ;
}

static VALUE getNodename(VALUE obj) {
	return rb_str_new_cstr(nodename) ;
}

static VALUE getRelease(VALUE obj) {
	return rb_str_new_cstr(release) ;
}

static VALUE getVersion(VALUE obj) {
	return rb_str_new_cstr(version) ;
}

static VALUE getMachine(VALUE obj) {
	return rb_str_new_cstr(machine) ;
}

void Init_utsname() {
	init_buf() ;

	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE _uname = rb_define_module_under(_linux_stat, "Uname") ;

	rb_define_module_function(_uname, "sysname", getSysname, 0) ;
	rb_define_module_function(_uname, "nodename", getNodename, 0) ;
	rb_define_module_function(_uname, "release", getRelease, 0) ;
	rb_define_module_function(_uname, "version", getVersion, 0) ;
	rb_define_module_function(_uname, "machine", getMachine, 0) ;
}
