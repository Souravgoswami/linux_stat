#include <sys/utsname.h>
#include "ruby.h"

static struct utsname buf ;
static VALUE machine, nodename ;

void init_buf() {
	short status = uname(&buf) ;
	machine = status < 0 ? rb_str_new_cstr("") : rb_str_new_cstr(buf.machine) ;
	nodename = status < 0 ? rb_str_new_cstr("") : rb_str_new_cstr(buf.nodename) ;
}

static VALUE getMachine(VALUE obj) {
	return machine ;
}

static VALUE getNodename(VALUE obj) {
	return nodename ;
}

void Init_utsname() {
	init_buf() ;

	VALUE _uname = rb_define_module("Uname") ;
	rb_define_module_function(_uname, "machine", getMachine, 0) ;
	rb_define_module_function(_uname, "nodename", getNodename, 0) ;
}
