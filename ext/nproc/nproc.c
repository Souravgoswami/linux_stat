#ifndef _GNU_SOURCE
	#define _GNU_SOURCE
#endif

#include <sched.h>
#include "ruby.h"

static VALUE count_cpu_for_pid(VALUE obj, VALUE pid) {
	cpu_set_t set;
	CPU_ZERO(&set);
	char status = sched_getaffinity(FIX2INT(pid), sizeof(set), &set);

	if (status < 0) return Qnil;
	return INT2FIX(CPU_COUNT(&set));
}

void Init_nproc() {
	VALUE _linux_stat = rb_define_module("LinuxStat");
	VALUE _nproc = rb_define_module_under(_linux_stat, "Nproc");
	rb_define_module_function(_nproc, "count_cpu_for_pid", count_cpu_for_pid, 1);
}
