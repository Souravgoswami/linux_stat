#include <sys/utsname.h>
#include "ruby.h"

static VALUE getMachine(VALUE obj) {
	struct utsname buf ;
	if ( uname(&buf) < 0 ) return rb_str_new_cstr("") ;
	return rb_str_new_cstr(buf.machine) ;
}

static VALUE getNodename(VALUE obj) {
	struct utsname buf ;
	if (uname(&buf) < 0 ) return rb_str_new_cstr("") ;
	return rb_str_new_cstr(buf.nodename) ;
}

void Init_utsname() {
	VALUE _uname = rb_define_module("Uname") ;
	rb_define_module_function(_uname, "machine", getMachine, 0) ;
	rb_define_module_function(_uname, "nodename", getNodename, 0) ;
}
