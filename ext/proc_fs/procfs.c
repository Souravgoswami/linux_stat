#include <stdio.h>
#include <unistd.h>
#include "ruby.h"
#include "uptime.h"
#include "statm.h"
#include "loadavg_pid.h"

int Init_procfs() {
	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE _procfs = rb_define_module_under(_linux_stat, "ProcFS") ;

	// uptime
	rb_define_module_function(_procfs, "uptime_f", uptime_f, 0) ;

	// statm
	rb_define_module_function(_procfs, "statm_memory", statm_memory, 1) ;
	rb_define_module_function(_procfs, "statm", statm, 1) ;
	rb_define_module_function(_procfs, "statm_virtual", statm_virtual, 1) ;
	rb_define_module_function(_procfs, "statm_resident", statm_resident, 1) ;
	rb_define_module_function(_procfs, "statm_shared", statm_shared, 1) ;

	// loadavg last PID
	rb_define_module_function(_procfs, "last_pid", last_pid, 0) ;
}
