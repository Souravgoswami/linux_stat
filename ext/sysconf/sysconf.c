#include <unistd.h>
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

static VALUE getTick(volatile VALUE obj) {
	int val = sysconf(_SC_CLK_TCK) ;
	if (val < 0) return Qnil ;

	return INT2FIX(val) ;
}

static VALUE getChildMax(volatile VALUE obj) {
	long long int val = sysconf(_SC_CHILD_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getHostnameMax(volatile VALUE obj) {
	long long val = sysconf(_SC_HOST_NAME_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getLoginNameMax(volatile VALUE obj) {
	long long val = sysconf(_SC_LOGIN_NAME_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getOpenMax(volatile VALUE obj) {
	long long val = sysconf(_SC_OPEN_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getPageSize(volatile VALUE obj) {
	int val = sysconf(_SC_PAGESIZE) ;
	if (val < 0) return Qnil ;

	return INT2FIX(val) ;
}

static VALUE getStreamMax(volatile VALUE obj) {
	long long val = sysconf(_SC_STREAM_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getTTYNameMax(volatile VALUE obj) {
	long long val = sysconf(_SC_TTY_NAME_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getPosixVersion(volatile VALUE obj) {
	long long val = sysconf(_SC_VERSION) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getLineMax(volatile VALUE obj) {
	long long val = sysconf(_SC_LINE_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getExprNestMax(volatile VALUE obj) {
	long long val = sysconf(_SC_EXPR_NEST_MAX) ;
	if (val < 0) return Qnil ;

	return LL2NUM(val) ;
}

static VALUE getProcessorConfigured(volatile VALUE obj) {
	long val = sysconf(_SC_NPROCESSORS_CONF) ;
	if (val < 0) return Qnil ;

	return LONG2NUM(val) ;
}

static VALUE getProcessorOnline(volatile VALUE obj) {
	long val = sysconf(_SC_NPROCESSORS_ONLN) ;
	if (val < 0) return Qnil ;

	return LONG2NUM(val) ;
}

static VALUE getUser(volatile VALUE obj) {
	char *name = getlogin() ;
	return name ? rb_str_new_cstr(name) : rb_str_new_cstr("") ;
}

static VALUE getUID(volatile VALUE obj) {
	return UINT2NUM((unsigned int) getuid()) ;
}

static VALUE getGID(VALUE obj) {
	return UINT2NUM((unsigned int) getgid()) ;
}

static VALUE getEUID(volatile VALUE obj) {
	return UINT2NUM((unsigned int) geteuid()) ;
}

static VALUE getHostname(volatile VALUE obj) {
	int h_max = sysconf(_SC_HOST_NAME_MAX) + 1 ;
	char hostname[h_max] ;

	char status = gethostname(hostname, h_max) ;

	return (status < 0) ? rb_str_new_cstr("") : rb_str_new_cstr(hostname) ;
}

void Init_sysconf() {
	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE _sysconf = rb_define_module_under(_linux_stat, "Sysconf") ;

	rb_define_module_function(_sysconf, "sc_clk_tck", getTick, 0) ;
	rb_define_module_function(_sysconf, "child_max", getChildMax, 0) ;
	rb_define_module_function(_sysconf, "hostname_max", getHostnameMax, 0) ;
	rb_define_module_function(_sysconf, "login_name_max", getLoginNameMax, 0) ;
	rb_define_module_function(_sysconf, "open_max", getOpenMax, 0) ;
	rb_define_module_function(_sysconf, "pagesize", getPageSize, 0) ;
	rb_define_module_function(_sysconf, "stream_max", getStreamMax, 0) ;
	rb_define_module_function(_sysconf, "tty_name_max", getTTYNameMax, 0) ;
	rb_define_module_function(_sysconf, "posix_version", getPosixVersion, 0) ;
	rb_define_module_function(_sysconf, "line_max", getLineMax, 0) ;
	rb_define_module_function(_sysconf, "expr_nest_max", getExprNestMax, 0) ;

	rb_define_module_function(_sysconf, "processor_online", getProcessorOnline, 0) ;
	rb_define_module_function(_sysconf, "processor_configured", getProcessorConfigured, 0) ;

	rb_define_module_function(_sysconf, "get_uid", getUID, 0) ;
	rb_define_module_function(_sysconf, "get_gid", getGID, 0) ;
	rb_define_module_function(_sysconf, "get_euid", getEUID, 0) ;

	rb_define_module_function(_sysconf, "get_user", getUser, 0) ;
	rb_define_module_function(_sysconf, "get_login", getUser, 0) ;

	rb_define_module_function(_sysconf, "hostname", getHostname, 0) ;
}
