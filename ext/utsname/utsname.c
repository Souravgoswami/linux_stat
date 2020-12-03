#include <sys/utsname.h>
#include "ruby.h"
#pragma GCC optimize ("O3")
#pragma clang optimize on

static struct utsname buf ;
static short status ;

void init_buf() {
	status = uname(&buf) ;
}

static VALUE getSysname(VALUE obj) {
	VALUE sysname = status < 0 ? rb_str_new_cstr("") : rb_str_new_cstr(buf.sysname) ;
	return sysname ;
}

static VALUE getNodename(VALUE obj) {
	VALUE nodename = status < 0 ? rb_str_new_cstr("") : rb_str_new_cstr(buf.nodename) ;
	return nodename ;
}

static VALUE getRelease(VALUE obj) {
	VALUE release = status < 0 ? rb_str_new_cstr("") : rb_str_new_cstr(buf.release) ;
	return release ;
}

static VALUE getVersion(VALUE obj) {
	VALUE version = status < 0 ? rb_str_new_cstr("") : rb_str_new_cstr(buf.version) ;
	return version ;
}

static VALUE getMachine(VALUE obj) {
	VALUE machine = status < 0 ? rb_str_new_cstr("") : rb_str_new_cstr(buf.machine) ;
	return machine ;
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
