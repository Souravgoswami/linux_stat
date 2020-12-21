#ifndef _GNU_SOURCE
	#define _GNU_SOURCE
#endif

#include <sched.h>
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

static VALUE nproc(VALUE obj) {
	cpu_set_t set ;
	CPU_ZERO(&set) ;
	sched_getaffinity(0, sizeof(set), &set) ;
	return INT2FIX(CPU_COUNT(&set)) ;
}

static VALUE count(VALUE obj) {
	return INT2FIX(sysconf(_SC_NPROCESSORS_CONF)) ;
}

void Init_nproc() {
	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE _cpu = rb_define_module_under(_linux_stat, "CPU") ;
	rb_define_module_function(_cpu, "nproc", nproc, 0) ;
	rb_define_module_function(_cpu, "count", count, 0) ;
}
