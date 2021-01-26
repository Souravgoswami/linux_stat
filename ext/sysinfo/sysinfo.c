#include <sys/sysinfo.h>
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

static struct sysinfo info ;

VALUE totalram(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.totalram) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE freeram(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.freeram) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE sharedram(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.sharedram) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE bufferram(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.bufferram) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE totalswap(VALUE obj) {
	static struct sysinfo info ;
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.totalswap) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE freeswap(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.freeswap) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE totalhigh(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.totalhigh) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE freehigh(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.freehigh) ;
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit) ;
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit) ;
}

VALUE uptime(VALUE obj) {
	short status = sysinfo(&info) ;
	if (status < 0) return Qnil ;

	unsigned long long v = info.uptime ;
	return ULL2NUM((unsigned long long) v) ;
}

VALUE loads(VALUE obj) {
	short status = sysinfo(&info) ;
	if(status < 0) return rb_ary_new() ;

	long double load = 1.f / (1 << SI_LOAD_SHIFT) ;

	float l_1 = info.loads[0] * load ;
	float l_5 = info.loads[1] * load ;
	float l_15 = info.loads[2] * load ;

	return rb_ary_new_from_args(3,
		rb_float_new(l_1),
		rb_float_new(l_5),
		rb_float_new(l_15)
	) ;
}

void Init_sysinfo() {
	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE _sysinfo = rb_define_module_under(_linux_stat, "Sysinfo") ;

	rb_define_module_function(_sysinfo, "totalram", totalram, 0) ;
	rb_define_module_function(_sysinfo, "freeram", freeram, 0) ;
	rb_define_module_function(_sysinfo, "sharedram", sharedram, 0) ;
	rb_define_module_function(_sysinfo, "bufferram", bufferram, 0) ;
	rb_define_module_function(_sysinfo, "totalswap", totalswap, 0) ;
	rb_define_module_function(_sysinfo, "freeswap", freeswap, 0) ;
	rb_define_module_function(_sysinfo, "totalhigh", totalhigh, 0) ;
	rb_define_module_function(_sysinfo, "freehigh", freehigh, 0) ;
	rb_define_module_function(_sysinfo, "uptime", uptime, 0) ;
	rb_define_module_function(_sysinfo, "loads", loads, 0) ;
}
