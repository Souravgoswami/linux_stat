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

// Function to return the sysname, or nil if uname fails
static VALUE getSysname(VALUE obj) {
	struct utsname buf;
	if (uname(&buf) == -1)
		return Qnil;

	return rb_str_new_cstr(buf.sysname);
}

// Function to return the nodename, or nil if uname fails
static VALUE getNodename(VALUE obj) {
	struct utsname buf;
	if (uname(&buf) == -1)
		return Qnil;

	return rb_str_new_cstr(buf.nodename);
}

// Function to return the release, or nil if uname fails
static VALUE getRelease(VALUE obj) {
	struct utsname buf;
	if (uname(&buf) == -1)
		return Qnil;

	return rb_str_new_cstr(buf.release);
}

// Function to return the version, or nil if uname fails
static VALUE getVersion(VALUE obj) {
	struct utsname buf;
	if (uname(&buf) == -1)
		return Qnil;

	return rb_str_new_cstr(buf.version);
}

// Function to return the machine type, or nil if uname fails
static VALUE getMachine(VALUE obj) {
	struct utsname buf;
	if (uname(&buf) == -1)
		return Qnil;

	return rb_str_new_cstr(buf.machine);
}

void Init_utsname() {
	VALUE _linux_stat = rb_define_module("LinuxStat");
	VALUE _uname = rb_define_module_under(_linux_stat, "Uname");

	rb_define_module_function(_uname, "sysname", getSysname, 0);
	rb_define_module_function(_uname, "nodename", getNodename, 0);
	rb_define_module_function(_uname, "release", getRelease, 0);
	rb_define_module_function(_uname, "version", getVersion, 0);
	rb_define_module_function(_uname, "machine", getMachine, 0);
}
